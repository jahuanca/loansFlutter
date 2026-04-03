import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

const double _heightOfCard = 50;

class ItemActionWidget extends StatelessWidget {
  final Size size;
  final String title;
  final String value;
  final void Function()? onTap;
  
  const ItemActionWidget({
    super.key,
    required this.size,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double height = _heightOfCard / 2;

    return Padding(
      padding: defaultPadding,
      child: Container(
        alignment: Alignment.center,
        width: size.width * 0.5 - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius()),
          border: Border.all(),
        ),
        child: ListTile(
          onTap: onTap,
          minTileHeight: height,
          title: Text(title),
          trailing: Text(value),
        ),
      ),
    );
  }
}
