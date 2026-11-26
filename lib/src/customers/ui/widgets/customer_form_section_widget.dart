import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

/// Bloque comun de cada seccion del formulario de cliente: titulo + campos.
/// `isScrollable: false` cuando varias secciones van dentro de un mismo scroll
/// (AddCustomerPage); un scroll dentro de otro no tiene altura definida y falla.
class CustomerFormSectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool isScrollable;

  const CustomerFormSectionWidget({
    super.key,
    required this.title,
    required this.children,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = Padding(
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
    return isScrollable ? SingleChildScrollView(child: content) : content;
  }
}

/// Borde de los inputs del formulario de cliente.
final InputBorder customerInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    borderSide: BorderSide(width: 0.25, color: primaryColor));

/// Los inputs del paquete utils piden un wrapper; aqui no se envuelven.
Widget customerNoWrapper(Widget child) => child;
