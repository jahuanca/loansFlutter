import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/ui/pages/loan_created/loan_created_controller.dart';
import 'package:loands_flutter/src/utils/core/format_date.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class LoanCreatedPage extends StatelessWidget {
  LoanCreatedPage({super.key});

  final LoanCreatedController controller = Get.find<LoanCreatedController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoanCreatedController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(
          text: 'Préstamo #${controller.summary.idLoan}',
          hasArrowBack: true,
          actions: [
            IconButton(
              onPressed: controller.copyInformation,
              icon: const Icon(Icons.copy_all),
            ),
          ],
        ),
        bottomNavigationBar: _bottomButtons(),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _header(),
            const SizedBox(height: 16),
            _summaryCard(),
            const SizedBox(height: 16),
            _quotasCard(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 72),
        const SizedBox(height: 8),
        Text(
          controller.summary.isRenewal
              ? loanRenewedSuccessString
              : loanCreatedSuccessString,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _summaryCard() {
    final summary = controller.summary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row(customerString, summary.customerName),
            _row(phoneString,
                summary.hasPhone ? summary.phone! : withoutPhoneString),
            _row(amountString, 'S/ ${summary.amount.formatDecimals()}'),
            _row(quantityOfQuotasString, '${summary.quotas.length}'),
            if (summary.quotas.isNotEmpty)
              _row(amountOfQuotaString,
                  'S/ ${summary.quotas.first.amount.formatDecimals()}'),
          ],
        ),
      ),
    );
  }

  Widget _quotasCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              datesOfQuotasString,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...controller.summary.quotas.map(_quotaRow),
          ],
        ),
      ),
    );
  }

  Widget _quotaRow(QuotaEntity quota) {
    final String date = quota.dateToPay
        .format(formatDate: FormatDate.summary)
        .orEmpty()
        .toCapitalize();
    return _row(quota.name, date);
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons() {
    return SafeArea(
      child: Padding(
        padding: defaultPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    text: whatsAppString,
                    fontSize: 16,
                    iconData: FontAwesomeIcons.whatsapp,
                    buttonStyle: ButtonStyleWidget.success,
                    padding: const EdgeInsets.only(right: 4),
                    onTap: controller.shareByWhatsApp,
                  ),
                ),
                Expanded(
                  child: ButtonWidget(
                    text: smsString,
                    fontSize: 16,
                    iconData: Icons.sms,
                    buttonStyle: ButtonStyleWidget.info,
                    padding: const EdgeInsets.only(left: 4),
                    onTap: controller.shareBySms,
                  ),
                ),
              ],
            ),
            ButtonWidget(
              text: goToHomeString,
              fontSize: 16,
              buttonType: ButtonTypeWidget.link,
              onTap: controller.goToHome,
            ),
          ],
        ),
      ),
    );
  }
}
