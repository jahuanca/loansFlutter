import 'package:loands_flutter/src/utils/domain/entities/activity_log_entity.dart';
import 'package:loands_flutter/src/utils/domain/repositories/utils_repository.dart';
import 'package:utils/utils.dart';

class GetLogsUseCase {

  UtilsRepository repository;

  GetLogsUseCase({
    required this.repository,
  });

  Future<ResultType<List<ActivityLogEntity>, ErrorEntity>> execute() {
    return repository.getLastsLog();
  }

}