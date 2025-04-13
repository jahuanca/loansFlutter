
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/di/add_loan_home_binding.dart';
import 'package:loands_flutter/src/loans/di/loan_detail_binding.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_loans_use_case.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_home/add_loan_home_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_detail/loan_detail_page.dart';
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

  void getLoans() async {
    validando = true;
    update([validandoIdGet]);
    ResultType<List<LoanEntity>, ErrorEntity> resultType = await getLoansUseCase.execute();
    if(resultType is Success){
      loans = resultType.data as List<LoanEntity>;
    }
    validando = false;
    update([pageIdGet, validandoIdGet]);
  }

  void goToAddLoanHome(){
    Get.to(()=> AddLoanHomePage(), binding: AddLoanHomeBinding(),);
  }

  void goToDetail(LoanEntity loanSelected) {
    Get.to( () => LoanDetailPage(), arguments: {
      'loanSelected': loanSelected,
    }, binding: LoanDetailBinding());
  }

}