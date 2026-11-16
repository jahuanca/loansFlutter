
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/domain/entities/capital_movement_entity.dart';
import 'package:loands_flutter/src/home/ui/pages/capital_movements/capital_movements_controller.dart';
import 'package:loands_flutter/src/utils/ui/widgets/totals_bottoms_widget.dart';
import 'package:utils/utils.dart';

class CapitalMovementsPage extends StatelessWidget {
  final CapitalMovementsController controller = Get.find<CapitalMovementsController>();
  CapitalMovementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CapitalMovementsController>(
      init: controller,
      id: pageIdGet,
      builder: (_) => RefreshIndicator(
        onRefresh: controller.getCapitalMovements,
        child: Scaffold(
          bottomNavigationBar: _bottomSection(),
          appBar: appBarWidget(text: 'Movimientos de caja'),
          body: ListView.builder(
            itemCount: controller.movements.length,
            itemBuilder: (context, index) => _itemMovement(controller.movements[index])),
        ),
      ),
    );
  }

  Widget _itemMovement(CapitalMovementEntity item) {
    String title = (item.type == 'I') ? 'Ingresos' : 'Salidas';
    String subtitle = (item.type == 'I') 
      ? 'Capital: ${item.amount?.formatDecimals()} \nGanancia: ${item.ganancy?.formatDecimals()}'
      : 'Monto: ${item.amount?.formatDecimals()}';

    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _bottomSection() {

    CapitalMovementEntity? first = controller.movements.firstOrNull;
    CapitalMovementEntity? last = controller.movements.lastOrNull;
    double outs = (first == null) ? 0 : (first.amount.orZero() + first.ganancy.orZero());
    double incomes = (last == null) ? 0 : (last.amount.orZero() + last.ganancy.orZero());

    return TotalsBottomsWidget(values: {
      'Salidas': outs.formatDecimals(),
      'Ingresos': incomes.formatDecimals(),
      'Invertir': (last?.ganancy).orZero().formatDecimals(),
    });
  }
}