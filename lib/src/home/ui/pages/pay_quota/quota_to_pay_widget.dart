import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class QuotaToPayWidget extends StatelessWidget {

  final String title;
  final String subtitle;
  final String amountFormatted;
  final String detail;

  const QuotaToPayWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amountFormatted,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      child: Card(
        elevation: 4,
        child: SizedBox(
            width: size.width,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: defaultPadding,
                  child: Text(
                    'S/ $amountFormatted',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(title),
                Text(
                  detail,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            )),
      ),
    );
  }

}