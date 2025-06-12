import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

Widget cardDashboardWidget({
  required String title,
  required Size size,
  required Map<String, dynamic> values,
  void Function()? onTap,
}) {
  const titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  List<Widget> items = [];

  items.add(Text(
    title,
    style: titleStyle,
  ));

  values.forEach((key, value) => items.add(
        _data(
          label: key,
          value: value,
          color: Colors.black,
        ),
      ));

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
          children: items,
        ),
      ),
    ),
  );
}

Widget _data({
  required String label,
  required dynamic value,
  required Color color,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label.capitalize() ),
      Text(
        '$value',
        style: TextStyle(
          color: color,
        ),
      ),
    ],
  );
}
