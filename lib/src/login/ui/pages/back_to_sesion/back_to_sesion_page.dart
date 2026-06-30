import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/back_to_sesion_controller.dart';
import 'package:utils/utils.dart';

class BackToSesionPage extends StatelessWidget {

  final BackToSesionController controller = BackToSesionController(
    loginUseCase: Get.find());

  BackToSesionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // aqui se puede crear una imagen diferente con accesos a chat, mostrar notificaciones etc
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<BackToSesionController>(
      init: controller,
      builder: (controller) =>  Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.9,
            child: Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: Center(child: Text('Bienvenido usuario')),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      PasswordInputWidget(
                        hintText: 'Contraseña',
                        onChanged: controller.onChangePassword,
                        )
                      ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _buttonsLogin(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonsLogin() {
    return Padding(
      padding: defaultPadding,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ButtonWidget(
              onTap:  controller.goToHome,
              text: 'Continuar'),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                onPressed: controller.goToHome, icon: const Icon(Icons.fingerprint_outlined)),
          ),
        ],
      ),
    );
  }
}
