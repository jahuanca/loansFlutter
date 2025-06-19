import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/di/add_loan_information_binding.dart';
import 'package:loands_flutter/src/loans/di/add_loan_special_binding.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_special/add_loan_special_page.dart';
import 'package:utils/utils.dart';

class AddLoanChooseTypeController extends GetxController {
  void goSelectedType(int index) {
    if (index == defaultInt) {
      Get.to(() => AddLoanInformationPage(),
          binding: AddLoanInformationBinding());
      return;
    }
    Get.to(() => AddLoanSpecialPage(), binding: AddLoanSpecialBinding());
  }
}
