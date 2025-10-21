
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/get_customers_use_case.dart';
import 'package:loands_flutter/src/loans/data/requests/add_renewal_request.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/renewal_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/add_renewal_use_case.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_loans_use_case.dart';
import 'package:loands_flutter/src/utils/core/enums_of_app.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class AddRenewalController extends GetxController {

  CustomerEntity? customerSelected;
  LoanEntity? previousLoan;
  LoanEntity? newLoan;

  GetCustomersUseCase getCustomersUseCase;
  GetLoansUseCase getLoansUseCase;
  AddRenewalUseCase addRenewalUseCase;

  List<CustomerEntity> customers = [];
  List<LoanEntity> loansPrevious = [];
  List<LoanEntity> loansNew = [];
  AddRenewalRequest addRenewalRequest = AddRenewalRequest();
  TextEditingController renewalDateTextController = TextEditingController();
  TextEditingController variationTextController = TextEditingController();
  TextEditingController typeRenewalTextController = TextEditingController();

  AddRenewalController({
    required this.getCustomersUseCase,
    required this.getLoansUseCase,
    required this.addRenewalUseCase,
  });

  @override
  void onReady() {
    getCustomers();
    super.onReady();
  }

  void getCustomers() async {
    showLoading();
    ResultType<List<CustomerEntity>, ErrorEntity> resultType = await getCustomersUseCase.execute();
    hideLoading();
    if (resultType is Error){

        return;
    }
    customers = resultType.data as List<CustomerEntity>;
    update([pageIdGet]);
  }

  void getLoans(int idCustomer) async {
    showLoading();
    ResultType<List<LoanEntity>, ErrorEntity> resultType = await getLoansUseCase.execute(
      GetLoansRequest(idCustomer: idCustomer)
    );
    hideLoading();
    if (resultType is Error){

        return;
    }
    loansPrevious.clear();
    loansPrevious = resultType.data as List<LoanEntity>;
    update([pageIdGet]);
  }

  void onChangedCustomer(dynamic value) {
    ValidateResult idCustomerValidationResult =
        validateText(text: value, label: customerString, rules: {
      RuleValidator.isRequired: true,
    });

    int index = customers.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      addRenewalRequest.idCustomer = idCustomerValidationResult.value;
      customerSelected = customers[index];
      getLoans(customerSelected!.id);
    }
  }

  void onChangedPreviousLoan(dynamic value) {
    previousLoan = loansPrevious.firstWhere((e) => e.id == value,);

    loansNew.clear();
    loansNew = loansPrevious.where((e) => e.startDate.isAfter(previousLoan!.startDate)).toList();
    update(['loans_new']);
    onChangeVariation();
  }

  void onChangedNewLoan(dynamic value) {
    newLoan = loansNew.firstWhere((e) => e.id == value);
    renewalDateTextController.text = newLoan!.startDate.formatDMMYYY().orEmpty();

    onChangeVariation();
  }

  void onChangeVariation() {
    if ([newLoan, previousLoan].contains(null)) return;
    double amountPrevious = previousLoan!.amount;
    double amountNew = newLoan!.amount;
    double variation = amountNew - amountPrevious;
    variationTextController = TextEditingController(text: variation.formatDecimals());

    TypeRenewalEnum type = TypeRenewalEnum.same;
    if (variation > 0) type = TypeRenewalEnum.increase;
    if (variation < 0) type = TypeRenewalEnum.decrease;
    typeRenewalTextController = TextEditingController(text: type.title);

    update([pageIdGet]);
  }

  void goCreate() async {
    if (addRenewalRequest.validate.not()) {
      showSnackbarWidget(context: Get.context!, typeSnackbar: TypeSnackbar.success, message: 'Dato no válido.');
      return;
    }
    showLoading();
    ResultType<RenewalEntity, ErrorEntity> resultType = await addRenewalUseCase.execute(addRenewalRequest);
    hideLoading();
    if (resultType is Error) {
      ErrorEntity errorEntity = resultType.error;
      showSnackbarWidget(context: Get.context!, typeSnackbar: TypeSnackbar.success, message: errorEntity.errorMessage);
      return;
    }
    Get.until((route) => route.settings.name == '/');
  }

}