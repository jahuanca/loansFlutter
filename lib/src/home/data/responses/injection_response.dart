
import 'dart:convert';

List<InjectionResponse> injectionResponseFromJson(String str) =>
    List<InjectionResponse>.from(
        json.decode(str).map((x) => InjectionResponse.fromJson(x)));

class InjectionResponse {
  DateTime periodo;
  double inversion;

  InjectionResponse({
    required this.inversion,
    required this.periodo,
  });

  factory InjectionResponse.fromJson(Map<String, dynamic> json) => InjectionResponse(
    inversion: (json['inversion'] as num).toDouble(), 
    periodo: DateTime.parse(json['periodo']));

  Map<String, dynamic> toJson() => {
    'inversion': inversion,
    'periodo': periodo.toIso8601String(),
  };

}