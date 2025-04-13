
import 'package:get/get.dart';
import 'package:loands_flutter/src/loans/domain/entities/loan_entity.dart';
import 'package:loands_flutter/src/loans/domain/entities/quota_entity.dart';
import 'package:loands_flutter/src/loans/domain/use_cases/get_all_quotas_use_case.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:utils/utils.dart';

class LoanDetailController extends GetxController {

  LoanEntity? loanSelected;
  List<QuotaEntity> quotas = [];
  GetAllQuotasUseCase getAllQuotasUseCase;

  LoanDetailController({
    required this.getAllQuotasUseCase,
  });

  @override
  void onInit() {
    loanSelected = Get.setArgument('loanSelected');
    super.onInit();
  }

  @override
  void onReady() {
    getQuotas();
    super.onReady();
  }

  void getQuotas() async {
    ResultType<List<QuotaEntity>, ErrorEntity> resultType = await getAllQuotasUseCase.execute({
      'id_loan': loanSelected?.id,
    });

    if(resultType is Success){
      quotas = resultType.data;
    }
    update(['quotas']);
  }

}