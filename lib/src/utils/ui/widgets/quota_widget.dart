import 'package:flutter/material.dart';
import 'package:loands_flutter/src/utils/core/colors.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:utils/utils.dart';

class QuotaWidget extends StatelessWidget {
  final int value;
  final Size size;
  final int total;
  final DateTime expirationDate;
  final double amountQuota;
  final double amortization;
  final double ganancy;
  final double percentage;
  final bool initiallyExpanded;
  final int? idStateQuota;
  final DateTime? paidDate;
  final double? amountDelinquency;
  final int? daysLate;
  final void Function()? onTapButton;

  const QuotaWidget({
    super.key,
    required this.value,
    required this.size,
    required this.total,
    required this.expirationDate,
    required this.amountQuota,
    required this.percentage,
    required this.amortization,
    required this.ganancy,
    this.idStateQuota,
    this.initiallyExpanded = false,
    this.onTapButton,
    this.paidDate,
    this.amountDelinquency,
    this.daysLate,
  });

  @override
  Widget build(BuildContext context) {
    final Widget header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor().withAlpha(126),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  '$value/$total',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Vence el: ${expirationDate.formatDMMYYY()}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 3,
            ),
            decoration: BoxDecoration(
                color: colorOfStateQuota(idStateQuota ?? idOfPendingQuota),
                borderRadius: BorderRadius.circular(12)),
            child: Text(
              ' S/ ${amountQuota.formatDecimals()}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
            )),
      ],
    );

    return Container(
      padding: defaultPadding,
      child: Card(
        color: Colors.white,
        child: ExpansionTile(
          shape: const Border(),
          initiallyExpanded: initiallyExpanded,
          title: header,
          children: [
            _childItem(
                title: paymentDateString,
                value: '${expirationDate.formatDMMYYY()}'),
            _childItem(
                title: 'Amortización',
                value: 's/ ${amortization.formatDecimals()}'),
            _childItem(
                title: 'Interés', value: 's/ ${ganancy.formatDecimals()}'),
            if (daysLate != null)
              _childItem(title: 'Días de mora', value: daysLate.toString()),
            if (amountDelinquency != null)
              _childItem(
                  title: 'Mora',
                  value: 's/ ${amountDelinquency?.formatDecimals()}'),
            if (idStateQuota != null)
              _childItem(
                  title: 'Estado',
                  value: idStateQuota == 1 ? 'PENDIENTE' : 'PAGADO'),
            if (paidDate != null)
              _childItem(
                  title: 'Pagado', value: paidDate!.formatDMMYYY().orEmpty()),
            if (onTapButton != null)
              Container(
                padding: defaultPadding,
                width: 150,
                height: 50,
                child: ButtonWidget(
                    onTap: onTapButton, fontSize: 14, text: payString),
              )
          ],
        ),
      ),
    );
  }

  Widget _childItem({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
