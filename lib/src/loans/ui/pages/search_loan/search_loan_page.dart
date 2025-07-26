import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class SearchLoanPage extends StatelessWidget {
  const SearchLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: appBarWidget(text: 'Buscar préstamo'),
      body: Column(
        children: [
          _appBar(size),
          const ListTile(
            title: Text('Value'),
          ),
          const ListTile(
            title: Text('Value'),
          ),
          const ListTile(
            title: Text('Value'),
          ),
        ],
      ),
    );
  }
  
  PreferredSizeWidget _appBar(Size size) {
    return AppBar(
      automaticallyImplyLeading: false,
      
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: '¿Qué desea buscar?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius())
            ),
            suffixIcon: const Icon(Icons.close),
          )),
      ));
  }
}