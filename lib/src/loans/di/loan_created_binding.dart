import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_created/loan_created_controller.dart';

class LoanCreatedBinding extends Bindings {
  @override
  void dependencies() {
    // Pantalla sin datos remotos: solo registra el controller.
    Get.lazyPut(() => LoanCreatedController());
  }
}
