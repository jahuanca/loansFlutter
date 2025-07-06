import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/quota_of_calendar_widget.dart';
import 'package:loands_flutter/src/home/ui/pages/quota_group/quota_group_controller.dart';
import 'package:utils/utils.dart';

class QuotaGroupPage extends StatelessWidget {

  final QuotaGroupController controller = QuotaGroupController(
    getQuotasByDateUseCase: Get.find(),
  );

  QuotaGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuotaGroupController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getQuotas,
        child: Scaffold(
          appBar: appBarWidget(
            text: controller.title,
            actions: [
              MenuOverlayWidget(
                //TODO: 
                //FIXME: ocurrio un error al buscar por fecha en home_calendar
                //TODO: copiar cuotas de ese día.
                // agrupar por dias las cuotas. (puede ser en un lisTile) y que cada
                // grupo se pueda copiar.
                // esto es probable que no sea necesario para el otro grupo
                // evaluar si se deja o no ese comportamiento.
                // crear una variable para mostrar agrupado por dias en listile o de forma normal.
                iconData: Icons.more_vert,
                padding: defaultPadding,
                items: const [
                  {
                    'id': 1,
                    'name': 'Filtrar',
                  },
                  {
                    'id': 2,
                    'name': 'Copiar',
                  },
                  {
                    'id': 3,
                    'name': 'Refrescar',
                  },
                ], onTapItem: (e) => {},),
            ]
          ),
          body: ChildOrElseWidget(
            condition: controller.quotas.isNotEmpty, 
            child: _listOfContent()),
        ),
      ),
    );
  }


  Widget _listOfContent() {
    return ListView.builder(
      itemCount: controller.quotas.length,
      itemBuilder: (context, index) => QuotaOfCalendarWidget(
        index: index,
        idStateQuota: controller.quotas[index].idStateQuota,
        amount: controller.quotas[index].amount,
        subtitle: controller.quotas[index].aliasOrName,
        detail: controller.quotas[index].dateToPay.formatDMMYYY().orEmpty(),
        idLoan: controller.quotas[index].idLoan.orZero(),
        title: controller.quotas[index].name,
        onTap: ()=> controller.goToQuota(index),
      ),);
  }
}