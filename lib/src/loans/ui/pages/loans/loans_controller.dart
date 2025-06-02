
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/di/add_loan_information_binding.dart';
import 'package:loands_flutter/src/loans/di/loan_detail_binding.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_loans_use_case.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_detail/loan_detail_page.dart';
import 'package:loands_flutter/src/loans/ui/widgets/loading_service.dart';
import 'package:utils/utils.dart';

class LoansController extends GetxController {

  GetLoansUseCase getLoansUseCase;
  List<LoanEntity> loans = [];
  bool validando = false;

  LoansController({
    required this.getLoansUseCase,
  });

  @override
  void onReady() {
    getLoans();
    super.onReady();
  }

  Future<void> getLoans() async {
    showLoading();
    ResultType<List<LoanEntity>, ErrorEntity> resultType = await getLoansUseCase.execute();
    if(resultType is Success){
      loans = resultType.data as List<LoanEntity>;
    }
    hideLoading();
    update([pageIdGet]);
  }

  void goToAddLoanInformation(){
    Get.to(()=> AddLoanInformationPage(), binding: AddLoanInformationBinding());
  }

  void goToDetail(LoanEntity loanSelected) {
    Get.to( () => LoanDetailPage(), arguments: {
      'loanSelected': loanSelected,
    }, binding: LoanDetailBinding());
  }

}