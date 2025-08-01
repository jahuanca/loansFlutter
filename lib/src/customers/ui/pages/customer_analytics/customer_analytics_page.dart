import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/data/responses/customer_analytics_response.dart';
import 'package:loands_flutter/src/customers/ui/pages/customer_analytics/customer_analytics_controller.dart';
import 'package:utils/utils.dart';

class CustomerAnalyticsPage extends StatelessWidget {
  final CustomerAnalyticsController controller = CustomerAnalyticsController(
    getCustomerAnalyticsUseCase: Get.find(),
  );

  CustomerAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GetBuilder<CustomerAnalyticsController>(
        init: controller,
        id: pageIdGet,
        builder: (controller) => Scaffold(
              appBar: appBarWidget(
                text: 'Analíticas de cliente',
                hasArrowBack: true,
              ),
              body: Column(
                children: [
                  _header(size),
                  _content(),
                ],
              ),
            ));
  }

  Widget _header(Size size) {
    return Container(
      padding: defaultPadding,
      width: size.width,
      child: Row(
        children: [
          Expanded(
              child: DropdownWidget(
                  items: controller.customers,
                  label: 'Clientes',
                  onChanged: controller.onChangedCustomer,
                  idLabel: 'aliasOrFullName',
                  hintText: 'Seleccione un cliente')),
          // const IconButtonWidget(iconData: Icons.search),
        ],
      ),
    );
  }

  Widget _content() {
    CustomerAnalyticsResponse? response = controller.response;
    TextStyle textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    final Widget content = Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Text(
              'Estadísticas',
              style: textStyle,
            ),
            _itemContent(
              label: 'Cantidad de prestamos',
              value: '${response?.amountOfLoans}',
            ),
            _itemContent(
              label: 'Ganancia generada',
              value: 'S/ ${response?.ganancy.formatDecimals()}',
            ),
            _itemContent(
              label: 'Prestamos en progreso',
              value: '${response?.loansInProgress}',
            ),
            _itemContent(
              label: 'Monto en progreso',
              value: 'S/ ${response?.amountInProgress.formatDecimals()}',
            ),
            _itemContent(
              label: 'Fecha de inicio',
              value: '${response?.startDate.formatDMMYYY()}',
            ),
            _itemContent(
              label: 'Antiguedad',
              value: '${response?.startDate.timeFromDate()}',
            ),
          ],
        ),
      ),
    );

    return ChildOrElseWidget(
        condition: controller.response != null, child: Column(
          children: [
            content,
            _buttonOfSearchLoans(),
          ],
        ));
  }

  Widget _itemContent({
    required String label,
    required String value,
  }) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: textStyle,
          )
        ],
      ),
    );
  }

  Widget _buttonOfSearchLoans() {
    return ButtonWidget(
      padding: defaultPadding,
      onTap: controller.goAllLoans,
      text: 'Ver préstamos');
  }
}
