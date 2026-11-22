import 'package:loands_flutter/src/customers/domain/entities/customer_payment_account_entity.dart';

/// Body que acepta el Joi de loans_node para una cuenta de pago.
/// Joi rechaza llaves desconocidas, por eso no se usa `entity.toJson()`
/// (que trae id, createdAt, paymentProvider, etc.).
class CustomerPaymentAccountRequest {
  final CustomerPaymentAccountEntity account;

  CustomerPaymentAccountRequest(this.account);

  /// Cuenta anidada en POST /customer/create (aun no existe idCustomer).
  Map<String, dynamic> toNestedJson() => {
        'idPaymentProvider': account.idPaymentProvider,
        'accountNumber': account.accountNumber,
        'cci': account.cci,
        'phone': account.phone,
        'holderName': account.holderName,
        'isDefault': account.isDefault,
        'observation': account.observation,
      };

  /// POST /customer-payment-account/create
  Map<String, dynamic> toCreateJson(int idCustomer) => {
        ...toNestedJson(),
        'idCustomer': idCustomer,
      };

  /// PUT /customer-payment-account/update (idCustomer no se envia: no cambia de cliente)
  Map<String, dynamic> toUpdateJson() => {
        ...toNestedJson(),
        'id': account.id,
      };
}
