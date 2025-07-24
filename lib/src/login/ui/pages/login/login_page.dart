import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_controller.dart';
import 'package:utils/utils.dart';

class LoginPage extends StatelessWidget {
  
  final LoginController controller = LoginController(loginUseCase: Get.find());
  final TextStyle _headerStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  final TextStyle _detailStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<LoginController>(
      id: pageIdGet,
      init: controller,
      builder: (controller) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.height * 0.9,
              child: Column(
                children: [
                  _image(),
                  _formContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return const Expanded(
      flex: 1,
      child: Align(
        child: Image(image: AssetImage('assets/icons/icon_app.png')),
      ),
    );
  }

  Widget _formContent() {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 5,
        ),
        decoration: BoxDecoration(
            color: Colors.white.withAlpha(250),
            borderRadius:
                const BorderRadius.only(topLeft: Radius.circular(70))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Iniciar sesión',
              style: _headerStyle,
            ),
            InputWidget(
              onChanged: controller.onChangeUsername,
              hintText: 'Ingrese su correo',
              label: 'Email',
              maxLength: 50,
            ),
            PasswordInputWidget(
              onChanged: controller.onChangePassword,
              hintText: 'Ingrese su contraseña',
              label: 'Contraseña',
            ),
            ButtonWidget(
                onTap: controller.goToHome, fontSize: 16, text: 'Ingresar'),
            const SizedBox(
              height: 25,
            ),
            Text(
              '¿Olvidaste tu contraseña? Presione aquí.',
              style: _detailStyle,
            )
          ],
        ),
      ),
    );
  }
}
