

import 'package:flutter/material.dart';

enum HomeSettingsEnum {
 changeEmail(title: 'Cambiar correo', icon: Icons.email_outlined,),
 changePassword(title: 'Cambiar contraseña', icon: Icons.password_outlined,),
 viewTutorial(title: 'Ver tutorial', icon: Icons.videocam_outlined,),
 chat(title: 'Chat', icon: Icons.chat_outlined,),
 logout(title: 'Cerrar sesión', icon: Icons.exit_to_app_outlined,),
 exit(title: 'Salir', icon: Icons.fullscreen_exit_sharp,);

 const HomeSettingsEnum({
  required this.title,
  required this.icon,
 });

  final String title;
  final IconData icon;
}