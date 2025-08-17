import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/di/add_loan_information_binding.dart';
import 'package:loands_flutter/src/loans/di/loan_detail_binding.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_choose_type/add_loan_choose_type_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_detail/loan_detail_page.dart';

class NavigationTo {
  static Future<dynamic>? goToAddLoanChooseType(
          [Map<String, dynamic>? arguments]) =>
      Get.to(
        () => AddLoanChooseTypePage(),
        binding: AddLoanInformationBinding(),
        arguments: arguments,
      );

  static Future<dynamic>? goToLoanDetail([Map<String, dynamic>? arguments]) =>
      Get.to(
        () => LoanDetailPage(),
        binding: LoanDetailBinding(),
        arguments: arguments,
      );
}
