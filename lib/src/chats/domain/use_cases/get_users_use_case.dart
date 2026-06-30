
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:loands_flutter/src/chats/domain/repositories/user_repository.dart';
import 'package:utils/utils.dart';

class GetUsersUseCase {

  UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<Result<List<UserEntity>, ErrorEntity>> execute() {
    return repository.getUsers();
  }

}