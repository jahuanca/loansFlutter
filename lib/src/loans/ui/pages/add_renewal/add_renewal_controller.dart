import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/customer_analytics_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/customer_analytics/customer_analytics_page.dart';
import 'package:loands_flutter/src/loans/data/requests/add_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/responses/get_metadata_renewal_response.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/renewal_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/add_renewal_use_case.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_metadata_renewal_use_case.dart';
import 'package:loands_flutter/src/utils/core/enums_of_app.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class AddRenewalController extends GetxController {
  CustomerEntity? customerSelected;

  GetMetadataRenewalResponse? getMetadataRenewalResponse;
  LoanEntity? previousLoanSelected;
  LoanEntity? newLoanSelected;

  GetCustomersUseCase getCustomersUseCase;
  GetMetadataRenewalUseCase getMetadataRenewalUseCase;
  AddRenewalUseCase addRenewalUseCase;

  List<CustomerEntity> customers = [];
  List<LoanEntity> loansPrevious = [];
  List<LoanEntity> loansNew = [];
  AddRenewalRequest addRenewalRequest = AddRenewalRequest();
  TextEditingController renewalDateTextController = TextEditingController();
  TextEditingController variationTextController = TextEditingController();
  TextEditingController typeRenewalTextController = TextEditingController();

  TextEditingController customerTextController = TextEditingController();
  TextEditingController newLoanTextController = TextEditingController();
  TextEditingController previousLoanTextController = TextEditingController();

  AddRenewalController({
    required this.getCustomersUseCase,
    required this.getMetadataRenewalUseCase,
    required this.addRenewalUseCase,
  });

  @override
  void onReady() {
    getCustomers();
    super.onReady();
  }

  void getCustomers() async {
    showLoading();
    ResultType<List<CustomerEntity>, ErrorEntity> resultType =
        await getCustomersUseCase.execute();
    hideLoading();
    if (resultType is Error) {
      return;
    }
    customers = resultType.data as List<CustomerEntity>;
    update([pageIdGet]);
  }

  void getLoans(int idCustomer) async {
    showLoading();
    ResultType<GetMetadataRenewalResponse, ErrorEntity> resultType =
        await getMetadataRenewalUseCase.execute(idCustomer);
    hideLoading();
    if (resultType is Error) {
      return;
    }
    loansNew.clear();
    getMetadataRenewalResponse = resultType.data as GetMetadataRenewalResponse;
    loansNew = getMetadataRenewalResponse?.newLoans ?? [];
    update([pageIdGet]);
  }

  void onChangedCustomer(dynamic value) {
    ValidateResult idCustomerValidationResult =
        validateText(text: value, label: customerString, rules: {
      RuleValidator.isRequired: true,
    });

    int index = customers.indexWhere((e) => e.id == value);
    if (index != notFoundPosition) {
      addRenewalRequest.idCustomer = idCustomerValidationResult.value;
      customerSelected = customers[index];
      getLoans(customerSelected!.id);
    }
  }

  void onChangedNewLoan(dynamic value) {
    newLoanSelected = loansNew.firstWhere((e) => e.id == value);
    addRenewalRequest.idNewLoan = newLoanSelected?.id;

    renewalDateTextController.text =
        newLoanSelected!.startDate.formatDMMYYY().orEmpty();
    addRenewalRequest.date = newLoanSelected?.startDate;

    if (getMetadataRenewalResponse == null) return;
    loansPrevious.clear();
    loansPrevious = getMetadataRenewalResponse!.previousLoans
        .where((e) => e.startDate.isBefore(newLoanSelected!.startDate))
        .toList();
    update(['loans_previous']);

    onChangeVariation();
  }

  void onChangedPreviousLoan(dynamic value) {
    previousLoanSelected = loansPrevious.firstWhere((e) => e.id == value);
    addRenewalRequest.idPreviousLoan = previousLoanSelected?.id;

    onChangeVariation();
  }

  void onChangeVariation() {
    if ([newLoanSelected].contains(null)) return;
    double amountPrevious = previousLoanSelected?.amount ?? defaultDouble;
    double amountNew = newLoanSelected!.amount;
    double variation = amountNew - amountPrevious;
    variationTextController =
        TextEditingController(text: variation.formatDecimals());
    addRenewalRequest.variationInAmount = variation;

    TypeRenewalEnum type = TypeRenewalEnum.same;
    if (variation > 0) type = TypeRenewalEnum.increase;
    if (variation < 0) type = TypeRenewalEnum.decrease;
    typeRenewalTextController = TextEditingController(text: type.title);
    addRenewalRequest.idTypeRenewal = type.id;

    update([pageIdGet]);
  }

  void goCreate() async {
    String? message = addRenewalRequest.validate;
    if (message != null) {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: message);
      return;
    }

    message = (previousLoanSelected == null)
        ? '¿Está seguro de crear la vinculación? No ha seleccionado un préstamo anterior.'
        : '¿Está seguro de crear la vinculación?';

    bool result = await showDialogWidget(
        context: Get.context!,
        message: message);
    if (!result) return;
    _goCreate();
  }

  void _goCreate() async {
    showLoading();
    ResultType<RenewalEntity, ErrorEntity> resultType =
        await addRenewalUseCase.execute(addRenewalRequest);
    hideLoading();
    if (resultType is Error) {
      ErrorEntity errorEntity = resultType.error;
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: errorEntity.errorMessage);
      return;
    }

    showSnackbarWidget(
      context: Get.context!, 
      typeSnackbar: TypeSnackbar.success, 
      message: 'Renovación vinculada.');

    clearInputs();
    // ME QUEDE EN EL 11: VICTOR FLORES
  }

  

  Future<void> goRefresh() async {
    clearInputs();
    getCustomers();
  }

  void clearInputs() {
    addRenewalRequest = AddRenewalRequest();
    customerSelected = null;
    newLoanSelected = null;
    previousLoanSelected = null;

    newLoanTextController.clear();
    previousLoanTextController.clear();
    renewalDateTextController.clear();
    variationTextController.clear();
    typeRenewalTextController.clear();
    customerTextController.clear();
    
    update([pageIdGet]);
  }

  Future<void> goCustomerAnalytics() async {
    await Get.to(
      () => CustomerAnalyticsPage(), 
      binding: CustomerAnalyticsBinding(),
      arguments: {
        customerArgument: customerSelected
      }
    );
  }

}