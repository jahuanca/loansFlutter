
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:utils/utils.dart';

abstract class UserDatastore {
  
  Future<Result<List<UserEntity>, ErrorEntity>> getUsers();

}