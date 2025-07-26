import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/requests/get_loans_request.dart';
import 'package:loands_flutter/src/loans/di/add_loan_information_binding.dart';
import 'package:loands_flutter/src/loans/di/loan_detail_binding.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_loans_use_case.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_choose_type/add_loan_choose_type_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_detail/loan_detail_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/search_loan/search_loan_page.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class LoansController extends GetxController {
  GetLoansUseCase getLoansUseCase;
  List<LoanEntity> loans = [];
  List<LoanEntity> loansToShow = [];
  bool isSearching = false;
  GetLoansRequest request = GetLoansRequest(
    idStateLoan: idOfPendingLoan,
  );
  bool isFromDashboard = true;
  String titleOfAppBar = 'Créditos';

  LoansController({required this.getLoansUseCase});

  @override
  void onInit() {
    GetLoansRequest? loanRequestofArgument = Get.setArgument(getLoansRequestArgument);
    String? titleOfArgument = Get.setArgument(titleOfAppBarArgument);
    if (loanRequestofArgument != null) {
      request = loanRequestofArgument;
      isFromDashboard = false;
    }
    if (titleOfArgument != null){
      titleOfAppBar = titleOfArgument;
    }
    super.onInit();
  }

  @override
  void onReady() {
    getLoans();
    super.onReady();
  }

  Future<void> getLoans() async {
    showLoading();
    ResultType<List<LoanEntity>, ErrorEntity> resultType =
        await getLoansUseCase.execute(request);
    if (resultType is Success) {
      loans = resultType.data as List<LoanEntity>;
      loansToShow.clear();
      loansToShow.addAll(loans);
    }
    hideLoading();
    update([pageIdGet]);
  }

  Future<void> goToAddLoanInformation() async {
    await Get.to(() => AddLoanChooseTypePage(),
        binding: AddLoanInformationBinding());
    getLoans();
  }

  void goToDetail(LoanEntity loanSelected) async {
    await Get.to(() => LoanDetailPage(),
        arguments: {
          loanSelectedArgument: loanSelected,
        },
        binding: LoanDetailBinding());
    getLoans();    
  }

  void goToSearchLoan() {
    Get.to(()=> const SearchLoanPage());
  }

  void searchValue(String value){
    
    if(value == emptyString){
      clearSearch();
      return;
    }
    isSearching = true;
    loansToShow.clear();
    loansToShow.addAll(
      loans.where((e) => e.customerEntity?.containValue(value) ?? false)
    );
    update([pageIdGet]);
  }

  void clearSearch() {
    isSearching = false;
    loansToShow.clear();
    loansToShow.addAll(loans);
    update([pageIdGet]);
  }
}
