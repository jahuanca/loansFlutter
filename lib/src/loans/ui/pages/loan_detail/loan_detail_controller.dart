import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_page.dart';
import 'package:loands_flutter/src/loans/data/requests/get_all_quotas_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_all_quotas_use_case.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
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

    QuotaEntity? quotaPaid = await Get.to<QuotaEntity>(() => PayQuotaPage(), arguments: {
      dashboardQuotaResponseArgument: DashboardQuotaResponse(
          id: quota.id!,
          idLoan: quota.idLoan!,
          name: quota.name,
          customerName: loanSelected?.customerEntity?.fullName ?? emptyString,
          amount: quota.amount,
          ganancy: quota.ganancy,
          idStateQuota: quota.idStateQuota,
          dateToPay: quota.dateToPay,
          paidDate: quota.paidDate,
        )
    });
    if(quotaPaid != null) getQuotas();
  }

  void shareInformation() async {

    QuotaEntity firstQuota = quotas.first;
    String information = emptyString;
    int? differenceDays = quotas.last.dateToPay.difference(loanSelected!.startDate.orNow()).inDays;
    String frecuency = loanSelected!.paymentFrequencyEntity!.name.orEmpty();

    information += 'Préstamo #${loanSelected?.id} \n';
    information +=
        'Cliente: ${loanSelected?.customerEntity?.aliasOrFullName} \n';
    information += 'Fecha: ${loanSelected?.startDate.format(formatDate: formatOfSummary)} \n';
    information += 'Duración: $differenceDays días ($frecuency)\n';
    information += 'Monto: S/ ${loanSelected?.amount.formatDecimals()} \n';
    information +=
        'Porcentaje: ${loanSelected?.percentage.formatDecimals()}% \n';

    information += 'Cantidad de cuotas: ${quotas.length}\n';
    information += 'Monto de cuota: S/ ${firstQuota.amount.formatDecimals()}\n';

    double amountToSendMe = firstQuota.amount - (firstQuota.ganancy / 2);

    information += 'Envíame: S/ ${amountToSendMe.formatDecimals()} \n';
    information += 'Fechas:';

    for (QuotaEntity quota in quotas) {
      String quotaInformation = quota.dateToPay.format(formatDate: formatOfSummary).orEmpty();
      information += '\n${quotaInformation.toCapitalize()}';
    }

    await copyToClipboard(information);
    showSnackbarWidget(
      context: Get.context!, 
      typeSnackbar: TypeSnackbar.success, 
      message: 'Información copiada');
  }
}
