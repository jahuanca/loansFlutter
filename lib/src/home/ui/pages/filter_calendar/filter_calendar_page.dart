
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class FilterCalendarPage extends StatelessWidget {
  const FilterCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(text: 'Filtro de búsqueda'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownWidget()
          ],
        ),
      ),
    );
  }
}
