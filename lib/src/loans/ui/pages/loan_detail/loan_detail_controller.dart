import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/home/ui/pages/pay_quota/pay_quota_page.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_all_quotas_use_case.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
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
    ResultType<List<QuotaEntity>, ErrorEntity> resultType =
        await getAllQuotasUseCase.execute({
      'id_loan': loanSelected?.id,
    });

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

    await Get.to(() => PayQuotaPage(), arguments: {
      dashboardQuotaResponseArgument: DashboardQuotaResponse(
          id: quota.id!,
          idLoan: quota.idLoan!,
          name: quota.name,
          customerName: loanSelected?.customerEntity?.fullName ?? emptyString,
          amount: quota.amount,
          idStateQuota: quota.idStateQuota,
          dateToPay: quota.dateToPay,
          paidDate: quota.paidDate,
        )
    });
    getQuotas();
  }

  void shareInformation() async {

    QuotaEntity firstQuota = quotas.first;
    String information = emptyString;
    int? differenceDays = quotas.last.dateToPay.difference(loanSelected!.startDate.orNow()).inDays + 1;

    information += 'Préstamo #${loanSelected?.id} \n';
    information +=
        'Cliente: ${loanSelected?.customerEntity?.aliasOrFullName} \n';
    information += 'Fecha: ${loanSelected?.startDate.formatDMMYYY()} \n';
    information += 'Duración: $differenceDays días\n';
    information += 'Monto: S/ ${loanSelected?.amount.formatDecimals()} \n';
    information +=
        'Porcentaje: ${loanSelected?.percentage.formatDecimals()}% \n';

    information += 'Cantidad de cuotas: ${quotas.length}\n';
    information += 'Monto de cuota: S/ ${firstQuota.amount.formatDecimals()}\n';

    double amountToSendMe = firstQuota.amount - (firstQuota.ganancy / 2);

    information += 'Envíame: S/ ${amountToSendMe.formatDecimals()} \n';
    information += 'Fechas:\n';

    for (QuotaEntity quota in quotas) {
      information += '${quota.dateToPay.format(formatDate: 'EEEE dd/MM/y')} \n';
    }

    await copyToClipboard(information);
    showSnackbarWidget(
      context: Get.context!, 
      typeSnackbar: TypeSnackbar.success, 
      message: 'Información copiada');
  }
}
