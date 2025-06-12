import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

Widget cardSingleDashboardWidget({
  required IconData icon,
  required String title,
  required String? value,
  required Size size,
  void Function()? onTap,
}) {

  const titleStyle =  TextStyle(
    fontWeight: FontWeight.bold,
  );

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.4,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Colors.grey.withAlpha(50),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title, style: titleStyle,),
            Row(
              children: [
                Icon(icon),
                Text(value.orEmpty()),
              ],
            )
          ],
        ),
      ),
    ),
  );
}