import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/settings/ui/pages/update_password/update_password_controller.dart';
import 'package:loands_flutter/src/utils/ui/widgets/bottom_buttons_widget.dart';
import 'package:utils/utils.dart';

class UpdatePasswordPage extends StatelessWidget {

  final UpdatePasswordController controller = UpdatePasswordController(
    updatePasswordUseCase: Get.find(),
  );

  UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdatePasswordController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Cambiar contraseña'),
        body: _body(),
        bottomNavigationBar: BottomButtonsWidget(items: [
          ItemBottomButtonWidget(
            title: 'Guardar', 
            onTap: controller.goToUpdatePassword,
          )
        ]),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          PasswordInputWidget(
            label: 'Contraseña actual',
            hintText: 'Ingrese su contraseña',
            onChanged: controller.onChangedCurrentPassword,
          ),

          PasswordInputWidget(
            label: 'Contraseña nueva',
            hintText: 'Ingrese su nueva contraseña',
            onChanged: controller.onChangedNewPassword,
          ),

          PasswordInputWidget(
            label: 'Repita contraseña',
            hintText: 'Repita la contraseña',
            onChanged: controller.onChangedRepeatPassword,
          ),
        ],
      ),
    );
  }
}