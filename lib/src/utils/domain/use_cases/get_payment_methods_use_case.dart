
import 'package:loands_flutter/src/utils/domain/entities/payment_method_entity.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:utils/utils.dart';

class GetPaymentMethodsUseCase {

  UtilsRepository repository;

  GetPaymentMethodsUseCase({
    required this.repository
  });

  Future<ResultType<List<PaymentMethodEntity>, ErrorEntity>> execute(){
    return repository.getMethodsPayment();
  }

}