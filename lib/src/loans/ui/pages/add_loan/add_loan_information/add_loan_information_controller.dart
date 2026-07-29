import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/add_customer_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/customer/get_customers_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_page.dart';
import 'package:loands_flutter/src/loans/data/requests/pay_and_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loan_request.dart';
import 'package:loands_flutter/src/loans/data/responses/get_metadata_renewal_response.dart';
import 'package:loands_flutter/src/loans/di/add_loan_quotas_binding.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_loan_use_case.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_metadata_renewal_use_case.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/validate_loan_use_case.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_ui.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_quotas/add_loan_quotas_page.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/source_to_loan_enum.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_frequencies_use_case.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_methods_use_case.dart';
import 'package:loands_flutter/src/utils/ui/pages/routes_app.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class AddLoanInformationController extends GetxController {
  late SourceToLoanEnum sourceToLoanEnum;
  PayAndRenewalRequest? createRenewalRequest;

  GetCustomersUseCase getCustomersUseCase;
  GetPaymentFrequenciesUseCase getPaymentFrequenciesUseCase;
  GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  ValidateLoanUseCase validateLoanUseCase;
  GetLoanUseCase getLoanUseCase;
  GetMetadataRenewalUseCase getMetadataRenewalUseCase;

  List<CustomerEntity> customers = [];
  List<PaymentFrequencyEntity> frequencies = [];
  List<PaymentFrequencyEntity> frequenciesOfCustomer = [];
  List<PaymentMethodEntity> methods = [];
  List<LoanEntity> loansPrevious = [];

  TextEditingController percentageTextController = TextEditingController();
  TextEditingController ganancyTextController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();
  TextEditingController amountTextController = TextEditingController();

  AddLoanInformationUi ui = AddLoanInformationUi();

  AddLoanInformationController({
    required this.getCustomersUseCase,
    required this.getPaymentFrequenciesUseCase,
    required this.getPaymentMethodsUseCase,
    required this.validateLoanUseCase,
    required this.getLoanUseCase,
    required this.getMetadataRenewalUseCase,
  });

  @override
  void onInit() {
    sourceToLoanEnum =
        Get.setArgument(sourceToLoanArgument) ?? SourceToLoanEnum.normal;
    createRenewalRequest = Get.setArgument(createRenewalRequestArgument);
    if (createRenewalRequest?.paidDate != null) {
      startDateTextController.text =
          createRenewalRequest?.paidDate.formatDMMYYY() ?? emptyString;
      onChangedStartDate(createRenewalRequest?.paidDate);
    }
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  void getData() async {
    showLoading();
    await Future.wait([
      getCustomers(),
      getPaymentFrecuencies(),
      getMethodsPayment(),
    ]);
    if (createRenewalRequest != null) {
      await getLoanToRenew();
    }
    hideLoading();
  }

  void getLoans(int idCustomer) async {
    loansPrevious.clear();
    ui.addLoanRequest.idLoanToRenew = null;
    showLoading();
    Result<GetMetadataRenewalResponse> resultType =
        await getMetadataRenewalUseCase.execute(idCustomer);
    hideLoading();
    switch (resultType) {
      case Success():
        GetMetadataRenewalResponse? getMetadataRenewalResponse =
            resultType.value;
        loansPrevious.addAll(getMetadataRenewalResponse.previousLoans);
        update([pageIdGet]);
        break;
      case Error():
        break;
    }
  }

  Future<void> getCustomers() async {
    Result<List<CustomerEntity>> resultType =
        await getCustomersUseCase.execute();
    switch (resultType) {
      case Success():
        customers = resultType.value;
        break;
      case Error():
        break;
    }
    update([customersIdGet]);
  }

  Future<void> getPaymentFrecuencies() async {
    Result<List<PaymentFrequencyEntity>> resultType =
        await getPaymentFrequenciesUseCase.execute();
    switch (resultType) {
      case Success():
        frequencies = resultType.value;
        frequencies.removeWhere((e) => e.id == idOfSpecialFrequency);
        break;
      case Error():
        break;
    }
    update([frequenciesIdGet]);
  }

  Future<void> getMethodsPayment() async {
    Result<List<PaymentMethodEntity>> resultType =
        await getPaymentMethodsUseCase.execute();
    switch (resultType) {
      case Success():
        methods = resultType.value;
        onChangedMethodsPayment(idOfMethodPaymentDefault);
        break;
      case Error():
        break;
    }
    update([methodsIdGet]);
  }

  Future<void> getLoanToRenew() async {
    Result<LoanEntity> resultType = await getLoanUseCase
        .execute(GetLoanRequest(id: createRenewalRequest?.idLoanToRenew));
    switch (resultType) {
      case Success():
        setLoanToRenew(resultType.value);
        break;
      case Error():
        break;
    }
  }

  void setLoanToRenew(LoanEntity loanToRenew) {
    onChangedCustomer(value: loanToRenew.idCustomer, isForChange: false);
    onChangedFrequency(loanToRenew.idPaymentFrequency);

    onChangeAmount(loanToRenew.amount.toString());
    String amount = loanToRenew.amount.formatDecimals();
    amountTextController = TextEditingController(text: amount);

    onChangedMethodsPayment(loanToRenew.idPaymentMethod);
    update([pageIdGet]);
  }

  void onChangedCustomer({
    required dynamic value,
    bool isForChange = true,
  }) {
    ui.idCustomer = validateText(text: value, label: customerString, rules: {
      RuleValidator.isRequired: true,
    });

    int index = customers.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      ui.customerSelected = customers[index];
      frequenciesOfCustomer.clear();
      frequenciesOfCustomer = frequencies
          .where(
            (e) => e.idTypeCustomer == ui.customerSelected?.idTypeCustomer,
          )
          .toList();
      if (isForChange) getLoans(ui.customerSelected!.id);
      update([frequenciesIdGet, customerIdGet]);
    }
  }

  void onChangedPreviousLoan(dynamic value) {
    int index = loansPrevious.indexWhere((e) => e.id == value);
    if (index != notFoundPosition) {
      ui.previousLoanSelected = loansPrevious[index];
    }
    update(['loans_previous']);
  }

  void onChangedFrequency(dynamic value, [bool setPercentage = true]) {
    ui.idPaymentFrequency =
        validateText(text: value, label: 'Frecuencia de pago', rules: {
      RuleValidator.isRequired: true,
    });

    int index = frequenciesOfCustomer.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      ui.frequencySelected = frequenciesOfCustomer[index];
      ui.idPaymentFrequency = ValidateResult.toInit(ui.frequencySelected?.id);
      if (setPercentage) changePercentage();
    }
  }

  void onChangedMethodsPayment(dynamic value) {
    ui.idPaymentMethod =
        validateText(text: value, label: paymentMethodString, rules: {
      RuleValidator.isRequired: true,
    });
    int index = methods.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      ui.methodSelected = methods[index];
    }
  }

  void changePercentage() {
    percentageTextController.text =
        '${ui.frequencySelected?.recommendedPercentage.formatDecimals()}';
    ui.percentage =
        ValidateResult.toInit(ui.frequencySelected?.recommendedPercentage);
    update([percentageIdGet]);
  }

  void onChangeAmount(String value) {
    ui.amount = validateText(
      text: value,
      label: amountString,
      rules: {
        RuleValidator.isRequired: true,
        RuleValidator.isDouble: true,
      },
      toConvert: ToConverter.toDouble,
    );
    update([amountIdGet]);
    calculateGanacy();
  }

  void calculateGanacy() {
    ganancyTextController.text = ui.ganancy.formatDecimals();
    update([ganancyIdGet]);
  }

  void onChangedStartDate(DateTime? date) {
    ui.startDate = validateText(text: date, label: startDateString, rules: {
      RuleValidator.isRequired: true,
      RuleValidator.isDatetime: true,
    });
    if (ui.startDate!.hasError) {
    } else {
      startDateTextController.text = date.formatDMMYYY().orEmpty();
    }
    update([startDayIdGet]);
  }

  void onChangedPercentage(String value) {
    ui.percentage = validateText(
      text: value,
      label: percentageString,
      rules: {
        RuleValidator.isRequired: true,
        RuleValidator.isDouble: true,
      },
      toConvert: ToConverter.toDouble,
    );
    if (ui.percentage!.hasError.not()) {
      if (ui.amount?.value != null) {
        onChangeAmount(ui.amount!.value.toString());
      }
    }
    update([percentageIdGet]);
  }

  ValidateResult? validate() {
    onChangedStartDate(ui.startDate?.value);
    onChangedCustomer(value: ui.idCustomer, isForChange: false);
    onChangedFrequency(ui.idPaymentFrequency, false);
    onChangedPercentage(ui.percentage.toString());
    onChangeAmount(ui.amount.toString());
    onChangedMethodsPayment(ui.idPaymentMethod);

    /*if (ui.startDate!.hasError) return ui.startDate!;
    if (ui.idCustomer!.hasError) {
      return ui.idCustomer!;
    }
    if (ui.idPaymentFrequency!.hasError) {
      return ui.idPaymentFrequency!;
    }
    if (ui.percentage!.hasError) {
      return ui.percentage!;
    }
    if (ui.amount!.hasError) return ui.amount!;
    if (ui.idPaymentMethod!.hasError) return ui.idPaymentMethod!;*/
    return ui.validate();
  }

  Future<void> goAddCustomer() async {
    await Get.to(() => AddCustomerPage(), binding: AddCustomerBinding());
    getCustomers();
  }

  Future<void> goCustomerAnalytics() async {
    if (ui.customerSelected == null) return;
    await RoutesApp.goCustomerAnalytics(customerSelected: ui.customerSelected!);
    getCustomers();
  }

  void goNext() async {
    ValidateResult? resultInformation = validate();
    if (resultInformation?.hasError ?? false) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: resultInformation?.error ?? emptyString);
      return;
    }

    if (loansPrevious.isNotEmpty && ui.previousLoanSelected == null) {
      bool isOkay = await showDialogWidget(
          context: Get.context!,
          message: 'Este prestamo será marcado sin renovación, ¿está seguro?');
      if (isOkay.not()) return;
    }
    bool? isValidate = await goValidate();
    if (isValidate == null) return;
    if (isValidate) {
      goQuotas();
    } else {
      bool result = await showDialogWidget(
          context: Get.context!,
          message: 'Se detecto un prestamo similar, ¿desea continuar?');
      if (result) goQuotas();
    }
  }

  void goQuotas() {
    if (ui.previousLoanSelected != null) {
      ui.idLoanToRenew = ui.previousLoanSelected?.id;
    }

    Get.to(() => AddLoanQuotasPage(),
        transition: Transition.noTransition,
        opaque: false,
        binding: AddLoanQuotasBinding(),
        arguments: {
          addLoanRequestArgument: ui.addLoanRequest,
          createRenewalRequestArgument: createRenewalRequest,
        });
  }

  void goBack() async {
    bool result =
        await showDialogWidget(context: Get.context!, message: alertBackString);
    if (result) Get.back();
  }

  Future<bool?> goValidate() async {
    Result<bool> resultType =
        await validateLoanUseCase.execute(ui.validateRequest);
    switch (resultType) {
      case Success():
        return resultType.value;
      case Error():
        return null;
    }
  }
}
