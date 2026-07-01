import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/back_to_sesion_controller.dart';
import 'package:loands_flutter/src/utils/ui/widgets/utils.dart';
import 'package:utils/utils.dart';

class BackToSesionPage extends StatelessWidget {
  final BackToSesionController controller =
      BackToSesionController(loginUseCase: Get.find());

  BackToSesionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // aqui se puede crear una imagen diferente con accesos a chat, mostrar notificaciones etc
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<BackToSesionController>(
      init: controller,
      builder: (controller) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: _body(size)),
      ),
    );
  }

  Widget _body(Size size) {
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height * 0.95,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(250),
            
          ),
          child: Column(
            children: [
              _welcomeMessage(),
              _form(),
              _shortCuts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _welcomeMessage() {
    return Expanded(
      flex: 2,
      child: Center(
          child: RichTextWidget(
        mainText: '\nBienvenido \n',
        mainStyle: const TextStyle(
          color: Colors.black,
        ),
        align: TextAlign.center,
        items: [
          RichTextItem(
              text: controller.username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          RichTextItem(
              text: '\n \nDigite su contraseña para iniciar sesión!',
              style: const TextStyle()),
        ],
      )),
    );
  }

  Widget _form() {
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          PasswordInputWidget(
            label: 'Contraseña',
            hintText: 'Ingresar contraseña',
            onChanged: controller.onChangePassword,
            textInputType: textInputPassword,
          ),
          TagWidget(
            onTap: controller.goToLogin,
            alignmentOfContent: MainAxisAlignment.center,
            title: 'Ingresar con otro usuario',
            backgroundColor: Colors.transparent,
            textColorAndIcon: infoColor(),
          ),
          _buttonsLogin()
        ],
      ),
    );
  }

  Widget _shortCuts() {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          const Text(
            '-Accesos directos-',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(children: [
            _itemShortCut(icon: Icons.analytics_outlined, title: 'Analíticas'),
            _itemShortCut(
                icon: Icons.calendar_month_outlined, title: 'Semana actual'),
            _itemShortCut(
                icon: Icons.post_add_outlined, title: 'Nuevo préstamo'),
          ]),
          const SizedBox(height: 32),
          Row(children: [
            _itemShortCut(
                icon: Icons.summarize_outlined, title: 'Resumen pagos'),
            _itemShortCut(
                icon: Icons.calendar_month_outlined, title: 'Vencidos'),
            _itemShortCut(
                icon: Icons.person_add_alt_1_outlined, title: 'Nuevo cliente'),
          ]),
        ],
      ),
    );
  }

  Widget _itemShortCut({
    required IconData icon,
    required String title,
  }) {
    return Expanded(
        child: Column(
      children: [IconWidget(iconData: icon), Text(title)],
    ));
  }

  Widget _buttonsLogin() {
    return Padding(
      padding: defaultPadding,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ButtonWidget(onTap: controller.goToHome, text: 'Continuar'),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                onPressed: controller.checkFinger,
                icon: const Icon(Icons.fingerprint_outlined)),
          ),
        ],
      ),
    );
  }
}
