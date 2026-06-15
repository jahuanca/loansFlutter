
import 'package:loands_flutter/src/home/data/responses/injection_response.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:utils/utils.dart';

class GetInjectionsUseCase {

  SummaryRepository repository;

  GetInjectionsUseCase(this.repository);

  Future<Result<List<InjectionResponse>, ErrorEntity>> execute() async {
    return repository.getInjections();
  }

}