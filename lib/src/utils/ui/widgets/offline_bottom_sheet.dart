import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class OfflineBottomSheet extends StatelessWidget {
  final InternetStatus status;
  const OfflineBottomSheet({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    if (status == InternetStatus.connected) {
      return Container();
    }

    final Size size = MediaQuery.sizeOf(context);

    return BottomSheet(
      builder: (context) => SizedBox(
        height: size.height * 0.4,
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Sin internet', style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),),
            ),

            ListTile(
              leading: Icon(Icons.signal_cellular_connected_no_internet_0_bar_sharp),
              title: Text('Activar el modo offline'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Salir de la aplicación'),
            ),
          ],
        ),
      ),
      onClosing: () => {},
    );
  }
}
