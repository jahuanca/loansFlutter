import 'package:get/get.dart';

extension Arguments on GetInterface {
  dynamic setArgument(
    String key
  ) {
    if(arguments != null){
      if(arguments[key] != null){
        return arguments[key];
      }
    }
  }
}