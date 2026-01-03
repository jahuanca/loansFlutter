
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/utils/core/format_date.dart';
import 'package:utils/utils.dart';

void shareInformation({
  required AddLoanRequest addLoanRequest,
  required List<QuotaEntity> quotas,
}) async {

    QuotaEntity firstQuota = quotas.first;
    String information = emptyString;
    int? differenceDays = quotas.last.dateToPay.difference(addLoanRequest.startDate.orNow()).inDays;
    String frecuency = addLoanRequest.paymentFrequencyEntity!.name.orEmpty();

    information += 'Préstamo #${addLoanRequest.id} \n';
    information +=
        'Cliente: ${addLoanRequest.customerEntity?.aliasOrFullName} \n';
    information += 'Fecha: ${addLoanRequest.startDate.format(formatDate: FormatDate.summary)} \n';
    information += 'Duración: $differenceDays días ($frecuency)\n';
    information += 'Monto: S/ ${addLoanRequest.amount?.formatDecimals()} \n';
    information +=
        'Porcentaje: ${addLoanRequest.percentage?.formatDecimals()}% \n';

    information += 'Cantidad de cuotas: ${quotas.length}\n';
    information += 'Monto de cuota: S/ ${firstQuota.amount.formatDecimals()}\n';

    double amountToSendMe = firstQuota.amount - (firstQuota.ganancy / 2);

    information += 'Envíame: S/ ${amountToSendMe.formatDecimals()} \n';
    information += 'Fechas:';

    for (QuotaEntity quota in quotas) {
      String quotaInformation = quota.dateToPay.format(formatDate: FormatDate.summary).orEmpty();
      information += '\n${quotaInformation.toCapitalize()}';
    }

    await copyToClipboard(information);
    showSnackbarWidget(
      context: Get.context!, 
      typeSnackbar: TypeSnackbar.success, 
      message: 'Información copiada');
  }


void shareInformationSpecial({
  required AddSpecialLoanRequest request,
  required List<QuotaEntity> quotas,
}) async {

    QuotaEntity firstQuota = quotas.first;
    String information = emptyString;
    int? differenceDays = quotas.last.dateToPay.difference(request.startDate.orNow()).inDays;
    String frecuency = 'Especial';

    information += 'Préstamo #${request.id} \n';
    information +=
        'Cliente: ${request.customerEntity?.aliasOrFullName} \n';
    information += 'Fecha: ${request.startDate.format(formatDate: FormatDate.summary)} \n';
    information += 'Duración: $differenceDays días ($frecuency)\n';
    information += 'Monto: S/ ${request.amount?.formatDecimals()} \n';
    information +=
        'Porcentaje: ${request.percentage?.formatDecimals()}% \n';

    information += 'Cantidad de cuotas: ${quotas.length}\n';
    information += 'Monto de cuota: S/ ${firstQuota.amount.formatDecimals()}\n';

    double amountToSendMe = firstQuota.amount - (firstQuota.ganancy / 2);

    information += 'Envíame: S/ ${amountToSendMe.formatDecimals()} \n';
    information += 'Fechas:';

    for (QuotaEntity quota in quotas) {
      String quotaInformation = quota.dateToPay.format(formatDate: FormatDate.summary).orEmpty();
      information += '\n${quotaInformation.toCapitalize()}';
    }

    await copyToClipboard(information);
    showSnackbarWidget(
      context: Get.context!, 
      typeSnackbar: TypeSnackbar.success, 
      message: 'Información copiada');
  }

// TODO: ambos metodos tienen mucho en similitud debe hacerse uno solo.