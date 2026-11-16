
import 'dart:convert';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/hive_db_config.dart';
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:utils/utils.dart';
import 'package:hive/hive.dart';
part 'loan_entity.g.dart';

List<LoanEntity> loanEntityFromJson(String str) => List<LoanEntity>.from(json.decode(str).map((x) => LoanEntity.fromJson(x)));

String loanEntityToJson(List<LoanEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: loanEntityIdAdapter)
class LoanEntity {
    @HiveField(0)
    int? id;
    @HiveField(1)
    int idCustomer;
    @HiveField(2)
    int idUser;
    @HiveField(3)
    int idPaymentFrequency;
    @HiveField(4)
    double amount;
    @HiveField(5)
    double percentage;
    @HiveField(6)
    DateTime startDate;
    @HiveField(7)
    double ganancy;
    @HiveField(8)
    int idPaymentMethod;
    @HiveField(9)
    String? observation;
    @HiveField(10)
    int idStateLoan;
    @HiveField(11)
    String evidence;
    @HiveField(12)
    DateTime createdAt;
    @HiveField(13)
    DateTime updatedAt;
    @HiveField(14)
    int numberOfInstallments;
    @HiveField(15)
    int daysBetweenInstallments;

    @HiveField(16)
    CustomerEntity? customerEntity;
    @HiveField(17)
    PaymentFrequencyEntity? paymentFrequencyEntity;

    LoanEntity({
        this.id,
        required this.idCustomer,
        required this.idUser,
        required this.idPaymentFrequency,
        required this.amount,
        required this.percentage,
        required this.startDate,
        required this.ganancy,
        required this.idPaymentMethod,
        required this.observation,
        required this.idStateLoan,
        required this.evidence,
        required this.createdAt,
        required this.updatedAt,
        required this.numberOfInstallments,
        required this.daysBetweenInstallments,
        this.customerEntity,
        this.paymentFrequencyEntity,
    });

    String get formatTitle => 'S/ ${amount.formatDecimals()} - ${percentage.formatDecimals()}%';

    bool get isCompleted => (idStateLoan == idOfCompleteLoan);

    String get name => '#P$id - ${startDate.format(formatDate: 'dd MMM')}: S/ ${amount.formatDecimals()}, ${paymentFrequencyEntity?.name}';
    
    bool get isSpecial => (idPaymentFrequency == idOfSpecialFrequency);

    factory LoanEntity.fromJson(Map<String, dynamic> json) => LoanEntity(
        id: json["id"],
        idCustomer: json["idCustomer"],
        idUser: json["idUser"],
        idPaymentFrequency: json["idPaymentFrequency"],
        amount: (json["amount"] as num).toDouble(),
        percentage: (json["percentage"] as num).toDouble(),
        startDate: DateTime.parse(json["startDate"]),
        ganancy: (json["ganancy"] as num).toDouble(),
        idPaymentMethod: json["idPaymentMethod"],
        observation: json["observation"],
        idStateLoan: json["idStateLoan"],
        evidence: json["evidence"],
        numberOfInstallments: json['numberOfInstallments'],
        daysBetweenInstallments: json['daysBetweenInstallments'],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        customerEntity: json['Customer'] == null ? null : CustomerEntity.fromJson(json['Customer']),
        paymentFrequencyEntity: json['PaymentFrequency'] == null ? null : PaymentFrequencyEntity.fromJson(json['PaymentFrequency']),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idCustomer": idCustomer,
        "idUser": idUser,
        "idPaymentFrequency": idPaymentFrequency,
        "amount": amount,
        "percentage": percentage,
        "startDate": startDate.toServer(),
        "ganancy": ganancy,
        "idPaymentMethod": idPaymentMethod,
        "observation": observation,
        "idStateLoan": idStateLoan,
        "evidence": evidence,
        'numberOfInstallments': numberOfInstallments,
        'daysBetweenInstallments': daysBetweenInstallments,
        "createdAt": createdAt.toServer(),
        "updatedAt": updatedAt.toServer(),
        'Customer': customerEntity?.toJson(),
        'PaymentFrequency': paymentFrequencyEntity?.toJson(),
        'name': name,
    };
}
