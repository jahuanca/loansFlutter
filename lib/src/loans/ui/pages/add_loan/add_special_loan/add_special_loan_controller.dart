import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/add_customer_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_page.dart';
import 'package:loands_flutter/src/loans/data/requests/add_special_loan_request.dart';
import 'package:loands_flutter/src/loans/di/add_special_loan_quotas_binding.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_special_loan_quotas/add_special_loan_quotas_page.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_frequencies_use_case.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_methods_use_case.dart';
import 'package:utils/utils.dart';

class AddSpecialLoanController extends GetxController {
  GetCustomersUseCase getCustomersUseCase;
  GetPaymentFrequenciesUseCase getPaymentFrequenciesUseCase;
  GetPaymentMethodsUseCase getPaymentMethodsUseCase;

  List<CustomerEntity> customers = [];
  List<PaymentFrequencyEntity> frequencies = [];
  List<PaymentMethodEntity> methods = [];

  CustomerEntity? customerSelected;
  PaymentFrequencyEntity? frequencySelected;
  PaymentMethodEntity? methodSelected;

  AddSpecialLoanRequest addSpecialLoanRequest = AddSpecialLoanRequest();
  TextEditingController percentageTextController = TextEditingController();
  TextEditingController ganancyTextController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();

  ValidateResult? startDateValidationResult,
      idCustomerValidationResult,
      idMethodValidationResult,
      percentageValidationResult,
      amountValidationResult,
      numberOfInstallmentsValidationResult,
      daysBetweenInstallmentsValidationResult;

  AddSpecialLoanController({
    required this.getCustomersUseCase,
    required this.getPaymentFrequenciesUseCase,
    required this.getPaymentMethodsUseCase,
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
      addSpecialLoanRequest.idCustomer = idCustomerValidationResult?.value;
      customerSelected = customers[index];
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
      addSpecialLoanRequest.paymentMethodEntity = methodSelected;
      addSpecialLoanRequest.idPaymentMethod = idMethodValidationResult?.value;
    }
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
      addSpecialLoanRequest.amount = amountValidationResult!.value;
    }
    update([amountIdGet]);
    calculateGanacy();
  }

  void onChangeDaysBetweenInstallments(String value) {
    daysBetweenInstallmentsValidationResult = validateText(
      text: value,
      label: 'Días entre cuotas',
      rules: {
        RuleValidator.isRequired: true,
      },
      toConvert: ToConverter.toInt,
    );
    if (daysBetweenInstallmentsValidationResult!.hasError.not()) {
      addSpecialLoanRequest.daysBetweenInstallments =
          daysBetweenInstallmentsValidationResult!.value;
    }
    update([daysBetweenInstallmentsIdGet]);
    calculateGanacy();
  }

  void onChangeNumberOfInstallments(String value) {
    numberOfInstallmentsValidationResult = validateText(
      text: value,
      label: 'Número de cuotas',
      rules: {
        RuleValidator.isRequired: true,
      },
      toConvert: ToConverter.toInt,
    );
    if (numberOfInstallmentsValidationResult!.hasError.not()) {
      addSpecialLoanRequest.numberOfInstallments =
          numberOfInstallmentsValidationResult!.value;
    }
    update([numberOfInstallmentsIdGet]);
    calculateGanacy();
  }

  void calculateGanacy() {
    addSpecialLoanRequest.ganancy = (addSpecialLoanRequest.amount.orZero()) *
        (addSpecialLoanRequest.percentage.orZero() / 100);
    ganancyTextController.text =
        '${addSpecialLoanRequest.ganancy?.formatDecimals()}';
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
      addSpecialLoanRequest.startDate = startDateValidationResult?.value;
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
      addSpecialLoanRequest.percentage = percentageValidationResult?.value;
      if (addSpecialLoanRequest.amount != null) {
        onChangeAmount(addSpecialLoanRequest.amount.toString());
      }
    }
    update([percentageIdGet]);
  }

  Future<void> goAddCustomer() async {
    await Get.to(() => AddCustomerPage(), binding: AddCustomerBinding());
    getCustomers();
  }

  void goNext() {
    String? message = addSpecialLoanRequest.validate;
    if (message != null) {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: message);
      return;
    }
    Get.to(() => AddSpecialLoanQuotasPage(),
        transition: Transition.noTransition,
        opaque: false,
        binding: AddSpecialLoanQuotasBinding(),
        arguments: {
          addLoanRequestArgument: addSpecialLoanRequest,
        });
  }

  void goBack() async {
    bool result =
        await showDialogWidget(context: Get.context!, message: alertBackString);
    if (result) {
      Get.back();
    }
  }
}
