
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/injection_response.dart';
import 'package:loands_flutter/src/home/ui/pages/injections/injections_controller.dart';
import 'package:loands_flutter/src/utils/core/format_date.dart';
import 'package:utils/utils.dart';

class InjectionsPage extends StatelessWidget {

  final controller = InjectionsController(
    getInjectionsUseCase: Get.find());

  InjectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InjectionsController>(
      id: pageIdGet,
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Inyecciones'),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: controller.injections.length,
      itemBuilder: (context, index) => _itemList(index));
  }

  Widget _itemList(int index) {
    InjectionResponse value = controller.injections[index];
    String? periodoFormatted = value.periodo.format(formatDate: FormatDate.summaryOfMonth)?.toCapitalize();
    String inversionFormatted = value.inversion.formatDecimals();

    return ListTile(
        title: Text(periodoFormatted.orEmpty()),
        subtitle: Text('S/ $inversionFormatted'),
      );
  }
}