
import 'dart:convert';

List<UserEntity> userEntityFromJson(String str) => List<UserEntity>.from(json.decode(str).map((x) => UserEntity.fromJson(x)));

String userEntityToJson(List<UserEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class UserEntity {
  int id;
  String name;
  String lastName;
  String email;
  String phoneNumber;
  bool isValidated;

  UserEntity({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.isValidated,
  });

  String get fullName => '$name $lastName';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'isValidated': isValidated,
      };

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json['id'],
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        isValidated: json['isValidated'],
      );
}
