import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class BottomButtonsWidget extends StatelessWidget {
  final List<ItemBottomButtonWidget> items;

  const BottomButtonsWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {

    final List<Widget> widgets = items
      .map(
        (e) => ButtonWidget(text: e.title, onTap: e.onTap,)
      ).toList();

    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Row(
        children: widgets,
      ),
    );
  }
}

class ItemBottomButtonWidget {
  String title;
  void Function()? onTap;

  ItemBottomButtonWidget({
    required this.title,
    required this.onTap,
  });
}
