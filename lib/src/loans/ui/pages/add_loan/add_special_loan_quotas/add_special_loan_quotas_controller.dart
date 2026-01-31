import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/dashboard_quota_response.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_special_request.dart';
import 'package:loands_flutter/src/loans/data/responses/pay_and_renewal_response.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/create_special_loan_use_case.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/pay_and_renewal_special_use_case.dart';
import 'package:loands_flutter/src/loans/ui/utils/share_loan_util.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class AddSpecialLoanQuotasController extends GetxController {
  late AddSpecialLoanRequest addLoanSpecialRequest;
  PayAndRenewalSpecialRequest? createRenewalSpecialRequest;

  CreateSpecialLoanUseCase createSpecialLoanUseCase;
  PayAndRenewalSpecialUseCase payAndRenewalSpecialUseCase;

  List<QuotaEntity> quotas = [];
  late double percentage;

  AddSpecialLoanQuotasController({
    required this.createSpecialLoanUseCase,
    required this.payAndRenewalSpecialUseCase,
  });

  @override
  void onInit() {
    addLoanSpecialRequest = Get.setArgument(addLoanRequestArgument);
    createRenewalSpecialRequest = Get.setArgument(createRenewalRequestArgument);
    setSpecialQuotas();
    super.onInit();
  }

  void setSpecialQuotas() {
    int quantity =
        addLoanSpecialRequest.numberOfInstallments ??
            defaultInt;
    DateTime startDate = addLoanSpecialRequest.startDate ?? defaultDate;
    int daysInstallment =
        addLoanSpecialRequest.daysBetweenInstallments ??
            defaultInt;
    percentage = addLoanSpecialRequest.percentage ?? defaultDouble;
    double amount = addLoanSpecialRequest.amount ?? defaultDouble;

    final double amountQuota = (amount * (1 + (percentage / 100)) / quantity);
    final double amortization = (amount / quantity);
    final double interest = amountQuota - amortization;

    for (var i = defaultInt; i < quantity; i++) {
      startDate = startDate.add(Duration(days: daysInstallment));
      QuotaEntity quota = QuotaEntity(
          name: '${i + 1}/$quantity',
          description: emptyString,
          amount: amountQuota,
          dateToPay: startDate,
          idStateQuota: idOfPendingQuota,
          ganancy: interest);
      quotas.add(quota);
    }
    update([pageIdGet]);
  }

  void create() async {
    bool result = await showDialogWidget(
        context: Get.context!, message: '¿Esta seguro de crear el préstamo especial?');
    if (result == false) return;
    showLoading();
    if (createRenewalSpecialRequest != null) {
      _createRenewal();
    } else {
      _createLoan();
    }  
    hideLoading();
  }

  void _createRenewal() async {

    createRenewalSpecialRequest?.amount = addLoanSpecialRequest.amount;
    createRenewalSpecialRequest?.percentage = addLoanSpecialRequest.percentage;
    createRenewalSpecialRequest?.startDate = addLoanSpecialRequest.startDate;
    createRenewalSpecialRequest?.idCustomer = addLoanSpecialRequest.idCustomer;
    createRenewalSpecialRequest?.customerEntity = addLoanSpecialRequest.customerEntity;
    createRenewalSpecialRequest?.idPaymentFrequency = idOfSpecialFrequency;
    createRenewalSpecialRequest?.idPaymentMethod = addLoanSpecialRequest.idPaymentMethod;
    createRenewalSpecialRequest?.ganancy = addLoanSpecialRequest.ganancy;
    createRenewalSpecialRequest?.numberOfInstallments = addLoanSpecialRequest.numberOfInstallments;
    createRenewalSpecialRequest?.daysBetweenInstallments = addLoanSpecialRequest.daysBetweenInstallments;

    ResultType<PayAndRenewalResponse, ErrorEntity> resultType =
          await payAndRenewalSpecialUseCase.execute(createRenewalSpecialRequest!);
      if (resultType is Error) {
        ErrorEntity errorEntity = resultType.error;
        showSnackbarWidget(
            context: Get.overlayContext!,
            typeSnackbar: TypeSnackbar.error,
            message: errorEntity.errorMessage);
        return;
      } else {
        PayAndRenewalResponse response = resultType.data;
        _successCreateRenewal(response.loan, response.quota);
      }
  }

  Future<void> _createLoan() async {
    ResultType<LoanEntity, ErrorEntity> resultType =
        await createSpecialLoanUseCase.execute(addLoanSpecialRequest);
    if (resultType is Error) {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: resultType.error);
      return;
    } else {
      LoanEntity newLoan = resultType.data;
      _successCreate(newLoan);
      Get.until((route) => route.settings.name == '/');
    }
  }

  void _successCreate(LoanEntity newLoan) async {
    addLoanSpecialRequest.id = newLoan.id;
    String information = shareInformationSpecial(
      request: addLoanSpecialRequest,
      quotas: quotas,
    );
    await copyToClipboard(information);
    showSnackbarWidget(
        context: Get.context!,
        typeSnackbar: TypeSnackbar.success,
        message: 'Información copiada');
    Get.until((route) => route.settings.name == '/');
  }

  void _successCreateRenewal(LoanEntity newLoan, QuotaEntity quota) async {
    addLoanSpecialRequest.id = newLoan.id;

    DashboardQuotaResponse quotaMapped = toDashboardResponse(
      newLoan: newLoan,
      quota: quota,
      customerName: addLoanSpecialRequest.customerEntity!.aliasOrFullName.orEmpty(),
      isSpecial: true,
    );
    String information = getInformationOfQuota(quotaMapped);
    information += "\n";
    information += shareInformationSpecial(
      request: addLoanSpecialRequest,
      quotas: quotas,
    );
    await copyToClipboard(information);
    showSnackbarWidget(
        context: Get.context!,
        typeSnackbar: TypeSnackbar.success,
        message: 'Información copiada');
    Get.until((route) => route.settings.name == '/');
  }
}