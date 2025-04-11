import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_controller.dart';
import 'package:utils/utils.dart';

enum Types {
  day,
  week,
}

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(text: 'Inicio'),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            _cards(),
            _details(),
          ],
        ),
      ),
    );
  }

  Widget _cards() {
    return GridView.count(
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      childAspectRatio: (6 / 4),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: [
        _card(
          icon: Icons.numbers,
          title: 'Créditos',
          mount: 120,
          onTap: controller.goToLoans
        ),
        _card(
          icon: Icons.monetization_on,
          title: 'Total prestado',
          mount: 120,
        ),
        _card(
          icon: Icons.upload_rounded,
          title: 'Ganancia',
          mount: 120,
        ),
        _card(
          icon: Icons.people,
          title: 'Clientes',
          mount: 120,
          onTap: controller.goToCustomers,
        ),
      ],
    );
  }

  Widget _card({
    required IconData icon,
    required String title,
    required double mount,
    void Function()? onTap,
  }) {
    const TextStyle amountStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.grey.withAlpha(50),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(icon),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    mount.formatDecimals(),
                    style: amountStyle,
                  ),
                ],
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _details() {

    const TextStyle subtitleStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pagos pendientes', style: subtitleStyle,),
                SegmentedButton(segments: const <ButtonSegment<Types>>[
                  ButtonSegment<Types>(
                    value: Types.day,
                    label: Text('Día'),
                    icon: Icon(Icons.calendar_view_day),
                  ),
                  ButtonSegment<Types>(
                    value: Types.week,
                    label: Text('Semana'),
                    icon: Icon(Icons.calendar_view_week),
                  ),
                ], selected: <Types>{
                  controller.selected
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
