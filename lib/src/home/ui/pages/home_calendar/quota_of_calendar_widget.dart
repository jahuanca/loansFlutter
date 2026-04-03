import 'package:flutter/material.dart';
import 'package:loands_flutter/src/home/data/responses/state_quota_enum.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:utils/utils.dart';

class QuotaOfCalendarWidget extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final int idLoan;
  final String title;
  final String subtitle;
  final String? detail;
  final double amount;
  final int? idStateQuota;
  final bool isSelected;
  final bool isLast;

  const QuotaOfCalendarWidget({
    super.key,
    required this.idLoan,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.idStateQuota,
    this.onTap,
    this.onLongPress,
    required this.isLast,
    this.isSelected = false,
    this.detail,
  });

  @override
  Widget build(BuildContext context) {
    StateQuotaEnum? enumOfStateQuota = findStateQuotaEnum(idStateQuota);

    return Padding(
      padding: defaultPadding,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          decoration: BoxDecoration(
            color: infoColor().withAlpha(isSelected ? 55 : 0),
            borderRadius: BorderRadius.circular(borderRadius()),
            border: Border.all(),
          ),
          padding: defaultPadding,
          child: Row(
            children: [
              _amountWidget(),
              _contentWidget(),
              ChildOrElseWidget(
                condition: isLast && idStateQuota != idOfCompleteQuota,
                child: Icon(Icons.info, color: infoColor()),
              ),
              if (enumOfStateQuota != null)
                _stateWidget(
                  title: enumOfStateQuota.name,
                  color: enumOfStateQuota.color,
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _amountWidget() {
    String amountValue = amount.formatDecimals();
    return Expanded(
        flex: 2,
        child: RichText(
          text: TextSpan(
            text: 'S/ ',
            style: const TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: amountValue, style: const TextStyle(fontSize: 24)),
            ],
          ),
        ));
  }

  Widget _contentWidget() {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('#P$idLoan: $title'),
          Text(subtitle.orEmpty()),
          if (detail != null) Text(detail.orEmpty()),
        ],
      ),
    );
  }

  Widget _stateWidget({
    required String title,
    required Color color,
  }) {
    return Expanded(
        flex: 2,
        child: TagWidget(
            alignmentOfContent: MainAxisAlignment.center,
            backgroundColor: color,
            textColorAndIcon: Colors.white,
            title: title));
  }
}
