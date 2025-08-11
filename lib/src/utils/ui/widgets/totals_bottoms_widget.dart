import 'package:flutter/material.dart';

class TotalsBottomsWidget extends StatelessWidget {
  final Map<String, String> values;

  const TotalsBottomsWidget({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    values.forEach((key, value) =>
        children.add(_itemBottomSection(title: key, value: value)));

    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 245, 245, 245),
        ),
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ));
  }

  Widget _itemBottomSection({
    required String title,
    required String value,
  }) {
    TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style: textStyle,
        ),
        Text('S/ $value'),
      ],
    );
  }
}
