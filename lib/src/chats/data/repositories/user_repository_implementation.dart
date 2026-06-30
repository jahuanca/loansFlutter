
import 'package:loands_flutter/src/chats/data/datastores/user_datastore.dart';
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:loands_flutter/src/chats/domain/repositories/user_repository.dart';
import 'package:utils/utils.dart';

class UserRepositoryImplementation extends UserRepository {

  UserDatastore datastore;

  UserRepositoryImplementation(this.datastore);

  @override
  Future<Result<List<UserEntity>, ErrorEntity>> getUsers() {
    return datastore.getUsers();
  }
}