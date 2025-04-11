
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/data/requests/add_loan_request.dart';
import 'package:utils/utils.dart';

class AddLoanQuotasController extends GetxController {

  AddLoanRequest addLoanRequest;
  AddLoanQuotasController({
    required this.addLoanRequest,
  });

  void setLoanRequest(AddLoanRequest value){
    addLoanRequest = value;
    update([pageIdGet]);
  }

  void create(){

  }

}