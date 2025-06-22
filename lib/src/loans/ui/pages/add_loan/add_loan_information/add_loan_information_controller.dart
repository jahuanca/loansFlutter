import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/add_customer_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_page.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/data/requests/validate_loan_request.dart';
import 'package:loands_flutter/src/loans/di/add_loan_quotas_binding.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/validate_loan_use_case.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_quotas/add_loan_quotas_page.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_frequencies_use_case.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_methods_use_case.dart';
import 'package:utils/utils.dart';

class AddLoanInformationController extends GetxController {
  GetCustomersUseCase getCustomersUseCase;
  GetPaymentFrequenciesUseCase getPaymentFrequenciesUseCase;
  GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  ValidateLoanUseCase validateLoanUseCase;

  List<CustomerEntity> customers = [];
  List<PaymentFrequencyEntity> frequencies = [];
  List<PaymentMethodEntity> methods = [];

  CustomerEntity? customerSelected;
  PaymentFrequencyEntity? frequencySelected;
  PaymentMethodEntity? methodSelected;

  AddLoanRequest addLoanRequest = AddLoanRequest();
  TextEditingController percentageTextController = TextEditingController();
  TextEditingController ganancyTextController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();

  ValidateResult? startDateValidationResult,
      idCustomerValidationResult,
      idFrequencyValidationResult,
      percentageValidationResult,
      amountValidationResult,
      idMethodValidationResult;

  AddLoanInformationController({
    required this.getCustomersUseCase,
    required this.getPaymentFrequenciesUseCase,
    required this.getPaymentMethodsUseCase,
    required this.validateLoanUseCase,
  });

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  void getData() async {
    await Future.wait([
      getCustomers(),
      getPaymentFrecuencies(),
      getMethodsPayment(),
    ]);
  }

  Future<void> getCustomers() async {
    ResultType<List<CustomerEntity>, ErrorEntity> resultType =
        await getCustomersUseCase.execute();
    if (resultType is Success) {
      customers = resultType.data;
    }
    update([customersIdGet]);
  }

  Future<void> getPaymentFrecuencies() async {
    ResultType<List<PaymentFrequencyEntity>, ErrorEntity> resultType =
        await getPaymentFrequenciesUseCase.execute();
    if (resultType is Success) {
      frequencies = resultType.data;
      frequencies.removeWhere((e) => e.id == idOfSpecialFrequency);
    }
    update([frequenciesIdGet]);
  }

  Future<void> getMethodsPayment() async {
    ResultType<List<PaymentMethodEntity>, ErrorEntity> resultType =
        await getPaymentMethodsUseCase.execute();
    if (resultType is Success) {
      methods = resultType.data;
      onChangedMethodsPayment(idOfMethodPaymentDefault);
    }
    update([methodsIdGet]);
  }

  void onChangedCustomer(dynamic value) {
    idCustomerValidationResult =
        validateText(text: value, label: customerString, rules: {
      RuleValidator.isRequired: true,
    });

    int index = customers.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      addLoanRequest.idCustomer = idCustomerValidationResult?.value;
      customerSelected = customers[index];
    }
  }

  void onChangedFrequency(dynamic value, [bool setPercentage = true]) {
    idFrequencyValidationResult =
        validateText(text: value, label: 'Frecuencia de pago', rules: {
      RuleValidator.isRequired: true,
    });

    int index = frequencies.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      frequencySelected = frequencies[index];
      addLoanRequest.paymentFrequencyEntity = frequencySelected;
      addLoanRequest.idPaymentFrequency = frequencySelected?.id;
      if(setPercentage) changePercentage();
    }
  }

  void onChangedMethodsPayment(dynamic value) {
    idMethodValidationResult =
        validateText(text: value, label: paymentMethodString, rules: {
      RuleValidator.isRequired: true,
    });
    int index = methods.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      methodSelected = methods[index];
      addLoanRequest.paymentMethodEntity = methodSelected;
      addLoanRequest.idPaymentMethod = idMethodValidationResult?.value;
    }
  }

  void changePercentage() {
    percentageTextController.text =
        '${frequencySelected?.recommendedPercentage.formatDecimals()}';
    addLoanRequest.percentage = frequencySelected?.recommendedPercentage;
    update([percentageIdGet]);
  }

  void onChangeAmount(String value) {
    amountValidationResult = validateText(
      text: value,
      label: amountString,
      rules: {
        RuleValidator.isRequired: true,
        RuleValidator.isDouble: true,
      },
      toConvert: ToConverter.toDouble,
    );
    if (amountValidationResult!.hasError.not()) {
      addLoanRequest.amount = amountValidationResult!.value;
    }
    update([amountIdGet]);
    calculateGanacy();
  }

  void calculateGanacy() {
    addLoanRequest.ganancy = (addLoanRequest.amount.orZero()) *
        (addLoanRequest.percentage.orZero() / 100);
    ganancyTextController.text = '${addLoanRequest.ganancy?.formatDecimals()}';
    update([ganancyIdGet]);
  }

  void onChangedStartDate(DateTime? date) {
    startDateValidationResult =
        validateText(text: date, label: startDateString, rules: {
      RuleValidator.isRequired: true,
      RuleValidator.isDatetime: true,
    });
    if (startDateValidationResult!.hasError) {
    } else {
      addLoanRequest.startDate = startDateValidationResult?.value;
      startDateTextController.text = date.formatDMMYYY().orEmpty();
    }
    update([startDayIdGet]);
  }

  void onChangedPercentage(String value) {
    percentageValidationResult = validateText(
      text: value,
      label: percentageString,
      rules: {
        RuleValidator.isRequired: true,
        RuleValidator.isDouble: true,
      },
      toConvert: ToConverter.toDouble,
    );
    if (percentageValidationResult!.hasError.not()) {
      addLoanRequest.percentage = percentageValidationResult?.value;
      if(addLoanRequest.amount != null){
        onChangeAmount(addLoanRequest.amount.toString());
      }
    }
    update([percentageIdGet]);
  }

  ValidateResult validate() {
    onChangedStartDate(addLoanRequest.startDate);
    onChangedCustomer(addLoanRequest.idCustomer);
    onChangedFrequency(addLoanRequest.idPaymentFrequency, false);
    onChangedPercentage(addLoanRequest.percentage.toString());
    onChangeAmount(addLoanRequest.amount.toString());
    onChangedMethodsPayment(addLoanRequest.idPaymentMethod);

    if (startDateValidationResult!.hasError) return startDateValidationResult!;
    if (idCustomerValidationResult!.hasError) {
      return idCustomerValidationResult!;
    }
    if (idFrequencyValidationResult!.hasError) {
      return idFrequencyValidationResult!;
    }
    if (percentageValidationResult!.hasError) {
      return percentageValidationResult!;
    }
    if (amountValidationResult!.hasError) return amountValidationResult!;
    if (idMethodValidationResult!.hasError) return idMethodValidationResult!;

    return ValidateResult(error: null, hasError: false, value: addLoanRequest);
  }

  Future<void> goAddCustomer() async {
    await Get.to(()=> AddCustomerPage(), binding: AddCustomerBinding());
    getCustomers();
  }

  void goNext() async {
    ValidateResult resultInformation = validate();
    if (resultInformation.hasError) {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: resultInformation.error ?? emptyString);
      return;
    }
    addLoanRequest = resultInformation.value as AddLoanRequest;
    bool? isValidate = await goValidate();
    if (isValidate == null) return;
    if (isValidate) {
      goQuotas();
    } else {
      bool result = await showDialogWidget(
        context: Get.context!, 
        message: 'Se detecto un prestamo similar, ¿desea continuar?');
      if(result) goQuotas();
    }
  }

  void goQuotas() {
    Get.to(
      ()=> AddLoanQuotasPage(), 
      transition: Transition.noTransition,
      opaque: false,
      binding: AddLoanQuotasBinding(),
    arguments: {
      addLoanRequestArgument: addLoanRequest,
    });
  }

  void goBack() async {
    bool result = await showDialogWidget(context: Get.context!, message: alertBackString);
    if (result) Get.back();
  }

  Future<bool?> goValidate() async {
    ResultType<bool, ErrorEntity> resultType = await validateLoanUseCase.execute(
      ValidateLoanRequest(
        idCustomer: addLoanRequest.idCustomer!, 
        idPaymentFrequency: addLoanRequest.idPaymentFrequency!, 
        percentage: addLoanRequest.percentage!, 
        amount: addLoanRequest.amount!, 
        startDate: addLoanRequest.startDate!)
    );
    if (resultType is Success) {
      return resultType.data;
    } else {
      return null;
    }
  }
}
