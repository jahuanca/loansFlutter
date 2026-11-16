import 'package:utils/utils.dart';

class RenewalEntity {

  int idUser;
  int? idPreviousLoan;
  int idNewLoan;
  DateTime date;
  double variationInAmount;
  String idTypeRenewal;
  String? observation;

  RenewalEntity({
    required this.idUser,
    this.idPreviousLoan,
    required this.idNewLoan,
    required this.date,
    required this.variationInAmount,
    required this.idTypeRenewal,
    this.observation,
  });

  factory RenewalEntity.fromJson(Map<String, dynamic> json) => RenewalEntity(
    idUser: json['idUser'], 
    idPreviousLoan: json['idPreviousLoan'], 
    idNewLoan: json['idNewLoan'], 
    date: DateTime.parse(json['date']), 
    variationInAmount: (json['variationInAmount'] as num).toDouble(), 
    idTypeRenewal: json['idTypeRenewal']);

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'idPreviousLoan': idPreviousLoan,
    'idNewLoan': idNewLoan,
    'date': date.toServer(),
    'variationInAmount': variationInAmount,
    'idTypeRenewal': idTypeRenewal,
  };
}