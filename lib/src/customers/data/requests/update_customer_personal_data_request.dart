import 'package:get/get_utils/get_utils.dart';
import 'package:utils/utils.dart';

/// Body de PUT /customer/update-personal-data (seccion Informacion personal).
/// El backend rechaza campos de otras secciones, por eso este request solo lleva estos.
class UpdateCustomerPersonalDataRequest {
  int id;
  int? idTypeDocument;
  String? document;
  String? alias;
  String? name;
  String? lastName;
  String? phone;

  UpdateCustomerPersonalDataRequest({
    required this.id,
    this.idTypeDocument,
    this.document,
    this.alias,
    this.name,
    this.lastName,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'idTypeDocument': idTypeDocument,
        'document': document,
        'alias': alias.isBlank.orFalse() ? null : alias,
        'name': name,
        'lastName': lastName,
        'phone': phone,
      };
}
