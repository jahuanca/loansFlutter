import 'package:flutter/material.dart';
import 'package:loands_flutter/src/loans/ui/widgets/options_enum.dart';
import 'package:utils/utils.dart';

class OptionsMenuWidget extends StatelessWidget {
  final void Function(dynamic) onTapItem;

  const OptionsMenuWidget({
    super.key,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return MenuOverlayWidget(
      iconData: Icons.more_vert,
      padding: defaultPadding,
      items: OptionsEnum.values.map(
        (e) => OptionMenu(id: e.id, name: e.title),
      ).toList(),
      onTapItem: onTapItem,
    );
  }
}
