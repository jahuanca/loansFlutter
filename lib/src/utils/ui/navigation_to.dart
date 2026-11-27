import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/di/add_loan_information_binding.dart';
import 'package:loands_flutter/src/loans/di/loan_created_binding.dart';
import 'package:loands_flutter/src/loans/di/loan_detail_binding.dart';
import 'package:loands_flutter/src/loans/ui/pages/add_loan/add_loan_choose_type/add_loan_choose_type_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_created/loan_created_page.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_detail/loan_detail_page.dart';
import 'package:loands_flutter/src/utils/core/routes_name.dart';

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

  /// Tras crear un préstamo: vuelve al contenido principal y encima abre la
  /// pantalla de éxito, así el "atrás" no regresa al formulario del préstamo.
  static Future<dynamic>? goToLoanCreated(Map<String, dynamic> arguments) {
    Get.until((route) =>
        route.settings.name == RoutesName.bottomNavigationContent.route);
    return Get.to(
      () => LoanCreatedPage(),
      binding: LoanCreatedBinding(),
      arguments: arguments,
    );
  }
}
