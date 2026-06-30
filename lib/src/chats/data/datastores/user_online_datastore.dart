
import 'package:loands_flutter/src/chats/data/datastores/user_datastore.dart';
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:utils/utils.dart';

class UserOnlineDatastore extends UserDatastore {
  @override
  Future<Result<List<UserEntity>, ErrorEntity>> getUsers() async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final AppResponseHttp response = await appHttpManager.get(
      url: '/user',
    );
    if (response.isSuccessful) {
      return Success( userEntityFromJson(response.body));
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

}