import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

/// Bloque comun de cada paso del formulario de cliente: titulo + campos.
class CustomerFormSectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const CustomerFormSectionWidget({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: defaultPadding,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

/// Borde de los inputs del formulario de cliente.
final InputBorder customerInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    borderSide: BorderSide(width: 0.25, color: primaryColor));

/// Los inputs del paquete utils piden un wrapper; aqui no se envuelven.
Widget customerNoWrapper(Widget child) => child;
