import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/di/add_loan_information_binding.dart';
import 'package:loands_flutter/src/loans/di/add_loan_special_binding.dart';
import 'package:loands_flutter/src/loans/di/add_renewal_binding.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_choose_type/add_loan_choose_options.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_information/add_loan_information_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_special_loan/add_special_loan_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_renewal/add_renewal_page.dart';

class AddLoanChooseTypeController extends GetxController {
  void goSelectedType(AddLoanChooseOptions value) {

    switch (value) {
      case AddLoanChooseOptions.normal:
        Get.to(() => AddLoanInformationPage(),
          binding: AddLoanInformationBinding());
        break;
      case AddLoanChooseOptions.special:
        Get.to(() => AddSpecialLoanPage(), binding: AddLoanSpecialBinding());
        break;
      case AddLoanChooseOptions.renewal:
        Get.to(() => AddRenewalPage(), binding: AddRenewalBinding());
        break;
      
    }    
  }
}
