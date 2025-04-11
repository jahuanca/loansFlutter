
import 'package:loands_flutter/src/utils/domain/entities/payment_frequency_entity.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:utils/utils.dart';

class GetPaymentFrequenciesUseCase {

  UtilsRepository repository;

  GetPaymentFrequenciesUseCase({
    required this.repository
  });

  Future<ResultType<List<PaymentFrequencyEntity>, ErrorEntity>> execute(){
    return repository.getPaymentFrecuencies();
  }

}