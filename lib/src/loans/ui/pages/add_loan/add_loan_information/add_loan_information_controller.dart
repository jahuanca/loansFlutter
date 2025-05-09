import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_home/add_loan_home_controller.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_frequencies_use_case.dart';
import 'package:loands_flutter/src/utils/domain/use_cases/get_payment_methods_use_case.dart';
import 'package:utils/utils.dart';

class AddLoanInformationController extends GetxController {
  GetCustomersUseCase getCustomersUseCase;
  GetPaymentFrequenciesUseCase getPaymentFrequenciesUseCase;
  GetPaymentMethodsUseCase getPaymentMethodsUseCase;

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

  get contentController => Get.find<AddLoanHomeController>();

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
  });

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  void getData() async {
    contentController.validando = true;
    contentController.update([validandoIdGet]);
    await Future.wait([
      getCustomers(),
      getPaymentFrecuencies(),
      getMethodsPayment(),
    ]);
    contentController.validando = false;
    contentController.update([validandoIdGet]);
  }

  Future<void> getCustomers() async {
    ResultType<List<CustomerEntity>, ErrorEntity> resultType =
        await getCustomersUseCase.execute();
    if (resultType is Success) {
      customers = resultType.data;
    } else {}
    update(['customers']);
  }

  Future<void> getPaymentFrecuencies() async {
    ResultType<List<PaymentFrequencyEntity>, ErrorEntity> resultType =
        await getPaymentFrequenciesUseCase.execute();
    if (resultType is Success) {
      frequencies = resultType.data;
    }
    update(['frequencies']);
  }

  Future<void> getMethodsPayment() async {
    ResultType<List<PaymentMethodEntity>, ErrorEntity> resultType =
        await getPaymentMethodsUseCase.execute();
    if (resultType is Success) {
      methods = resultType.data;
    }
    update(['methods']);
  }

  void onChangedCustomer(dynamic value) {
    idCustomerValidationResult =
        validateText(text: value, label: 'Cliente', rules: {
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

  void onChangedFrequency(dynamic value) {
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
      changePercentage();
    }
  }

  void onChangedMethods(dynamic value) {
    idMethodValidationResult =
        validateText(text: value, label: 'Método de pago', rules: {
      RuleValidator.isRequired: true,
    });
    int index = methods.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      methodSelected = methods[index];
      addLoanRequest.paymentMethodEntity = methodSelected;
      addLoanRequest.idPaymenyMethod = idMethodValidationResult?.value;
    }
  }

  void changePercentage() {
    percentageTextController.text =
        '${frequencySelected?.recommendedPercentage.formatDecimals()}';
    addLoanRequest.percentage = frequencySelected?.recommendedPercentage;
    update(['percentage']);
  }

  void onChangeAmount(String value) {
    amountValidationResult = validateText(
      text: value,
      label: 'Monto',
      rules: {
        RuleValidator.isRequired: true,
        RuleValidator.isDouble: true,
      },
      toConvert: ToConverter.toDouble,
    );
    if (amountValidationResult!.hasError.not()) {
      addLoanRequest.amount = amountValidationResult!.value;
    }
    update(['aomunt']);
    calculateGanacy();
  }

  void calculateGanacy() {
    addLoanRequest.ganancy = (addLoanRequest.amount.orZero()) *
        (addLoanRequest.percentage.orZero() / 100);
    ganancyTextController.text = '${addLoanRequest.ganancy?.formatDecimals()}';
    update(['ganancy']);
  }

  void onChangedStartDate(DateTime? date) {
    startDateValidationResult =
        validateText(text: date, label: 'Fecha de inicio', rules: {
      RuleValidator.isRequired: true,
      RuleValidator.isDatetime: true,
    });
    if (startDateValidationResult!.hasError) {
    } else {
      addLoanRequest.startDate = startDateValidationResult?.value;
      startDateTextController.text = date.formatDMMYYY().orEmpty();
    }
    update(['start_date']);
  }

  void onChangedPercentage(String value) {
    percentageValidationResult = validateText(
      text: value,
      label: 'Porcentaje',
      rules: {
        RuleValidator.isRequired: true,
        RuleValidator.isDouble: true,
      },
      toConvert: ToConverter.toDouble,
    );
    if (percentageValidationResult!.hasError.not()) {
      addLoanRequest.percentage = percentageValidationResult?.value;
    }
    update(['percentage']);
  }

  ValidateResult validate() {
    onChangedStartDate(addLoanRequest.startDate);
    onChangedCustomer(addLoanRequest.idCustomer);
    onChangedFrequency(addLoanRequest.idPaymentFrequency);
    onChangedPercentage(addLoanRequest.percentage.toString());
    onChangeAmount(addLoanRequest.amount.toString());
    onChangedMethods(addLoanRequest.idPaymenyMethod);

    if (startDateValidationResult!.hasError) return startDateValidationResult!;
    if (idCustomerValidationResult!.hasError)
      return idCustomerValidationResult!;
    if (idFrequencyValidationResult!.hasError)
      return idFrequencyValidationResult!;
    if (percentageValidationResult!.hasError)
      return percentageValidationResult!;
    if (amountValidationResult!.hasError) return amountValidationResult!;
    if (idMethodValidationResult!.hasError) return idMethodValidationResult!;

    return ValidateResult(error: null, hasError: false, value: addLoanRequest);
  }
}
