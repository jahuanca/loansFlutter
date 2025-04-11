import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/login/ui/pages/login/login_controller.dart';
import 'package:loands_flutter/src/utils/ui/widgets/input_label_widget.dart';
import 'package:utils/utils.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  final double _sizeOfImage = 65;
  final TextStyle _headerStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  final TextStyle _detailStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                _image(),
                _formContent(
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return Expanded(
      flex: 1,
      child: Align(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          width: _sizeOfImage,
          height: _sizeOfImage,
          child: const Icon(
            Icons.attach_money_sharp,
            color: Colors.black,
            size: 45,
          ),
        ),
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
            const InputLabelWidget(
              hintText: 'Ingrese su correo',
              label: 'Email',
            ),
            const InputLabelWidget(
              hintText: 'Ingrese su contraseña',
              label: 'Contraseña',
            ),
            ButtonWidget(
              onTap: controller.goToHome,
              fontSize: 16, text: 'Ingresar'),
            const SizedBox(height: 25,),
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
