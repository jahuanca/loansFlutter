
import 'package:loands_flutter/src/home/domain/entities/capital_movement_entity.dart';
import 'package:loands_flutter/src/home/domain/repositories/summary_repository.dart';
import 'package:utils/utils.dart';

class GetCapitalMovementsGroupUseCase {

  SummaryRepository repository;

  GetCapitalMovementsGroupUseCase(this.repository);

  Future<Result<List<CapitalMovementEntity>>> execute() {
    return repository.getCapitalMovementsGroup();
  }

}