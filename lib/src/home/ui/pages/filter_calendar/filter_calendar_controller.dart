
import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/domain/use_cases/get_users_use_case.dart';

class FilterCalendarController extends GetxController {

  GetUsersUseCase getUsersUseCase;

  FilterCalendarController({
    required this.getUsersUseCase,
  });

}