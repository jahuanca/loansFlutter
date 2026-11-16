
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/domain/entities/capital_movement_entity.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_capital_movements_group_use_case.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class CapitalMovementsController extends GetxController {

  GetCapitalMovementsGroupUseCase getCapitalMovementsGroupUseCase;
  List<CapitalMovementEntity> movements = [];

  CapitalMovementsController({
    required this.getCapitalMovementsGroupUseCase,
  });

  @override
  void onReady() {
    getCapitalMovements();
    super.onReady();
  }

  Future<void> getCapitalMovements() async {
    showLoading();
    final Result<List<CapitalMovementEntity>> resultType = await getCapitalMovementsGroupUseCase.execute();
    final data = executeResultUI<List<CapitalMovementEntity>>(resultType);
    if (data != null) {
      movements = data;
      update([pageIdGet]);
    }
    hideLoading();
    
  }

}