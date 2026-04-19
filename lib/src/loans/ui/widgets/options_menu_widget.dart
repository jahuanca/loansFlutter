import 'package:flutter/material.dart';
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
      items: [
        OptionMenu(id: 1, name: 'Filtrar'),
        OptionMenu(id: 2, name: 'Copiar'),
        OptionMenu(id: 3, name: 'Configurar'),
      ],
      onTapItem: onTapItem,
    );
  }
}
