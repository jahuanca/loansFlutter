
import 'package:loands_flutter/src/settings/data/datastores/settings_datastore.dart';
import 'package:utils/utils.dart';

class SettingsOnlineDatastore extends SettingsDatastore {

  @override
  Future<Result<void, ErrorEntity>> updatePassword(String currentPassword, String newPassword) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response = await appHttpManager.put(
        url: '/user/update-password', body: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        });
    if (response.isSuccessful) {
      return const Success(null);
    } else {
      return Error(
          ErrorEntity(
              statusCode: response.statusCode,
              title: response.title,
              errorMessage: response.body));
    }
  }

}