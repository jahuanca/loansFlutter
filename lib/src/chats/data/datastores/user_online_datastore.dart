import 'package:loands_flutter/src/chats/data/datastores/user_datastore.dart';
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:utils/utils.dart';

class UserOnlineDatastore extends UserDatastore {
  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final Result<AppResponseHttp> response = await appHttpManager.get(
      url: '/user',
    );

    return executeResponseList<List<UserEntity>>(
        response: response, convert: userEntityFromJson);
  }
}
