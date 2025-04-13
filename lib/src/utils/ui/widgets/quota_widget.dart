import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class QuotaWidget extends StatelessWidget {
  final int value;
  final Size size;
  final int total;
  final DateTime date;
  final int daysToAdd;
  final double amount;
  final double percentage;

  const QuotaWidget({
    super.key,
    required this.value,
    required this.size,
    required this.total,
    required this.date,
    required this.daysToAdd,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final double amountQuota = (amount * (1 + (percentage / 100)) / total);
    final double amortization = (amount / total);
    final double interest = amountQuota - amortization;

    final DateTime expirationDate =
        date.add(Duration(days: (value * daysToAdd)));

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
                color: alertColor(), borderRadius: BorderRadius.circular(12)),
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
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: ExpansionTile(
          shape: const Border(),
          initiallyExpanded: true,
          title: header,
          children: [
            _childItem(
                title: 'Fecha de pago',
                value: '${expirationDate.formatDMMYYY()}'),
            _childItem(
                title: 'Amortización',
                value: 's/ ${amortization.formatDecimals()}'),
            _childItem(
                title: 'Interés', value: 's/ ${interest.formatDecimals()}'),
            _childItem(title: 'Días de mora', value: '0'),
            _childItem(title: 'Mora', value: 's/ 0.00'),
            _childItem(title: 'Estado', value: 'PENDIENTE'),
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
