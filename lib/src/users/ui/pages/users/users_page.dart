import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/users/ui/pages/users/users_controller.dart';
import 'package:utils/utils.dart';

class UsersPage extends GetView<UsersController> {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(text: 'Usuarios'),
    );
  }
}