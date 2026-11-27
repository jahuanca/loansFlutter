import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_created/loan_created_summary.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/routes_name.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class LoanCreatedController extends GetxController {
  late LoanCreatedSummary summary;

  @override
  void onInit() {
    summary = Get.setArgument(loanCreatedSummaryArgument);
    super.onInit();
  }

  Future<void> copyInformation() async {
    await copyToClipboard(summary.information);
    showSnackbarWidget(
      context: Get.context!,
      typeSnackbar: TypeSnackbar.success,
      message: informationCopiedString,
    );
  }

  Future<void> shareByWhatsApp() => _share(sendingWhatsApp);

  Future<void> shareBySms() => _share(sendingSMSWithMessage);

  /// Valida que el cliente tenga celular, copia el resumen al portapapeles
  /// (por si la app destino no recibe el texto) y abre WhatsApp o SMS.
  Future<void> _share(
    Future<void> Function({
      required String phoneNumber,
      required String message,
    }) send,
  ) async {
    if (!summary.hasPhone) {
      await showAlertWidget(
        context: Get.context!,
        message: customerWithoutPhoneString,
      );
      return;
    }
    await copyToClipboard(summary.information);
    try {
      await send(
        phoneNumber: summary.phone!.trim(),
        message: summary.information,
      );
    } catch (_) {
      showSnackbarWidget(
        context: Get.context!,
        typeSnackbar: TypeSnackbar.error,
        message: couldNotOpenAppString,
      );
    }
  }

  void goToHome() {
    Get.until(
        (route) => route.settings.name == RoutesName.bottomNavigationContent.route);
  }
}
