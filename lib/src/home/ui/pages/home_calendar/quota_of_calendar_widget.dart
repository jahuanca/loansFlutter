import 'package:flutter/material.dart';
import 'package:loands_flutter/src/home/data/responses/state_quota_enum.dart';
import 'package:utils/utils.dart';

class QuotaOfCalendarWidget extends StatelessWidget {
  final int index;
  final void Function()? onTap;
  final int idLoan;
  final String title;
  final String subtitle;
  final String detail;
  final double amount;
  final int idStateQuota;

  const QuotaOfCalendarWidget({
    super.key,
    required this.index,
    this.onTap,
    required this.idLoan,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.idStateQuota,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {

    StateQuotaEnum enumOfStateQuota = findStateQuotaEnum(idStateQuota);
    String amountValue = amount.formatDecimals();
    String nameStateQuota = enumOfStateQuota.name;
    Color colorStateQuota = enumOfStateQuota.color;

    return Padding(
      padding: defaultPadding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius()),
            border: Border.all(),
          ),
          padding: defaultPadding,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: RichText(
                    text: TextSpan(
                      text: 'S/ ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: amountValue,
                            style: const TextStyle(fontSize: 24)),
                      ],
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('#P$idLoan: $title'),
                    Text(subtitle.orEmpty()),
                    Text(detail.orEmpty()),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: TagWidget(
                      alignmentOfContent: MainAxisAlignment.center,
                      backgroundColor: colorStateQuota,
                      textColorAndIcon: Colors.white,
                      title: nameStateQuota)),
            ],
          ),
        ),
      ),
    );
  }
}
