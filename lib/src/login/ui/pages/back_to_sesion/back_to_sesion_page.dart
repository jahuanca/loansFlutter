import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/back_to_sesion_controller.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/direct_access_enum.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
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
              _shortCuts(size),
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
          child: Column(
        children: [
          RichTextWidget(
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
          ),
          GetBuilder<BackToSesionController>(
              id: directAccessIdGet,
              builder: (controller) => (controller.directAccessSelected != null)
                  ? RichTextWidget(
                      mainText: '\n \nDirigirme a:  ',
                      mainStyle: const TextStyle(
                        color: Colors.black
                      ),
                      items: [
                        RichTextItem(
                            text: controller.directAccessSelected?.title ?? emptyString,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    )
                  : Container()),
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

  Widget _shortCuts(Size size) {
    return GetBuilder<BackToSesionController>(
      id: directAccessIdGet,
      builder: (controller) => Expanded(
        flex: 2,
        child: Column(
          children: [
            const Text(
              '-Accesos directos-',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: DirectAccessEnum.values.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) =>
                  _itemShortCut(DirectAccessEnum.values[index]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemShortCut(DirectAccessEnum directAccess) {
    return Container(
      color: (controller.directAccessSelected == directAccess)
          ? infoColor()
          : Colors.transparent,
      child: GestureDetector(
        onTap: () => controller.onChangedDirectAccess(directAccess),
        child: Column(
          children: [
            IconWidget(iconData: directAccess.icon),
            Text(directAccess.title)
          ],
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
