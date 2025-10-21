import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_page.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_all_quotas_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_all_quotas_use_case.dart';
import 'package:loands_flutter/src/loans/ui/utils/share_loan_util.dart';
import 'package:loands_flutter/src/utils/core/source_to_loan_enum.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class LoanDetailController extends GetxController {
  LoanEntity? loanSelected;
  List<QuotaEntity> quotas = [];
  GetAllQuotasUseCase getAllQuotasUseCase;

  LoanDetailController({
    required this.getAllQuotasUseCase,
  });

  @override
  void onInit() {
    loanSelected = Get.setArgument(loanSelectedArgument);
    super.onInit();
  }

  @override
  void onReady() {
    getQuotas();
    super.onReady();
  }

  Future<void> getQuotas() async {
    showLoading();
    
    GetAllQuotasRequest request = GetAllQuotasRequest(
      idLoan: loanSelected?.id,
    );

    ResultType<List<QuotaEntity>, ErrorEntity> resultType =
        await getAllQuotasUseCase.execute(request);

    if (resultType is Success) {
      quotas = resultType.data;
    }
    hideLoading();
    update([pageIdGet]);
  }

  Future<void> goToPayQuota() async {
    QuotaEntity? quota = quotas.firstWhereOrNull((e) => e.idStateQuota == idOfPendingQuota);
    if (quota == null) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: 'No se encontró cuota por pagar');
      return;
    }

    bool result = await showDialogWidget(
        context: Get.context!,
        message:
            '¿Desea iniciar el pago de la cuota ${quota.name}, Vence: ${quota.dateToPay.formatDMMYYY()}?');
    if (result == false) return;

    DashboardQuotaResponse dashboardQuotaResponse = DashboardQuotaResponse(
          id: quota.id!,
          idLoan: quota.idLoan!,
          name: quota.name,
          customerName: loanSelected?.customerEntity?.fullName ?? emptyString,
          amount: quota.amount,
          ganancy: quota.ganancy,
          idStateQuota: quota.idStateQuota,
          dateToPay: quota.dateToPay,
          paidDate: quota.paidDate,
        );

    QuotaEntity? quotaPaid = await Get.to<QuotaEntity>(
      () => PayQuotaPage(), arguments: {
      sourceToLoanArgument: SourceToLoanEnum.listLoans,
      dashboardQuotaResponseArgument: dashboardQuotaResponse,
    });
    
    if(quotaPaid != null) getQuotas();
  }

  void goShareInformation() async {
    if (loanSelected == null) return;
    shareInformation(
      addLoanRequest: AddLoanRequest.fromLoanEntity(loanSelected!), 
      quotas: quotas
    );
  }
}
