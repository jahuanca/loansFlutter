import 'package:loands_flutter/src/settings/data/datastores/settings_datastore.dart';
import 'package:utils/utils.dart';

class SettingsOnlineDatastore extends SettingsDatastore {
  @override
  Future<Result<void>> updatePassword(
      String currentPassword, String newPassword) async {
    final AppHttpManager appHttpManager = AppHttpManager();
    final response =
        await appHttpManager.put(url: '/user/update-password', body: {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    });
    switch (response) {
      case Success():
        final value = response.value;
        if (value.isSuccessful) {
          return Result.success(null);
        } else {
          final error = ErrorEntity(
            title: value.title,
            statusCode: value.statusCode,
            errorMessage: value.detail,
          );
          return Result.error(error);
        }
      case Error():
        return Result.error(response.error);
    }
  }
}
