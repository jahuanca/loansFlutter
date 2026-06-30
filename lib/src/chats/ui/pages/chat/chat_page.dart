import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: appBarWidget(text: 'Yo'),
      body: const Text('Listado de mensajes'),
      bottomNavigationBar: _bottomNavigation(size),
    );
  }

  Widget _bottomNavigation(Size size) {
    return SizedBox(
      height: kBottomNavigationBarHeight * 1.1,
      width: size.width,
      child: Row(
        children: [
          Expanded(child: InputWidget(hintText: 'Mensaje')),
          
          const SizedBox(
            width: 36,
            child: IconWidget(iconData: Icons.send),
          ),
        ],
      ),
    );
  }
}