import 'package:loands_flutter/src/utils/core/strings.dart';

/// Secciones del cliente que se editan desde su detalle reutilizando los pasos del alta.
enum EditCustomerSection {
  personalData(editPersonalInformationString),
  manageData(editTypeOfCustomerString);

  final String title;

  const EditCustomerSection(this.title);
}
