import 'package:loands_flutter/src/utils/domain/entities/payment_provider_entity.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:utils/utils.dart';

/// Catalogo de proveedores de pago (bancos y billeteras) desde /utils/payment-provider.
class GetPaymentProvidersUseCase {
  UtilsRepository repository;

  GetPaymentProvidersUseCase({required this.repository});

  Future<Result<List<PaymentProviderEntity>>> execute() {
    return repository.getPaymentProviders();
  }
}
