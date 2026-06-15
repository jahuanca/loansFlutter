
import 'package:get/get.dart';
import 'package:loands_flutter/src/home/data/responses/injection_response.dart';
import 'package:loands_flutter/src/home/domain/use_cases/get_injections_use_case.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

class InjectionsController extends GetxController {

  GetInjectionsUseCase getInjectionsUseCase;
  List<InjectionResponse> injections = [];

  InjectionsController({
    required this.getInjectionsUseCase,
  });

  @override
  void onReady() {
    getInjections();
    super.onReady();
  }

  Future<void> getInjections() async {
    showLoading();
    Result<List<InjectionResponse>, ErrorEntity> result = await getInjectionsUseCase.execute();
    hideLoading();
    switch (result) {
      case Success():
        injections = result.value;
        break;
      case Error():
        break;
    }
    update([pageIdGet]);
  }

}