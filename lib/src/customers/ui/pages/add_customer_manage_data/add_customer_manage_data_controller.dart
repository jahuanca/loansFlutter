import 'package:get/get.dart';
import 'package:loands_flutter/src/chats/domain/entities/user_entity.dart';
import 'package:loands_flutter/src/chats/domain/use_cases/get_users_use_case.dart';
import 'package:loands_flutter/src/customers/domain/entities/type_customer_entity.dart';
import 'package:loands_flutter/src/customers/domain/use_cases/type_customer/get_types_customer_use_case.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_controller.dart';
import 'package:loands_flutter/src/customers/ui/pages/add_customer/add_customer_ui.dart';
import 'package:loands_flutter/src/utils/core/helpers.dart';
import 'package:loands_flutter/src/utils/core/ids_get.dart';
import 'package:loands_flutter/src/utils/core/strings.dart';
import 'package:loands_flutter/src/utils/ui/widgets/loading/loading_service.dart';
import 'package:utils/utils.dart';

/// Paso 4: tipo de cliente y recuperador asignado.
class AddCustomerManageDataController extends GetxController {
  AddCustomerController addCustomerController;
  GetTypesCustomerUseCase getTypesCustomerUseCase;
  GetUsersUseCase getUsersUseCase;

  List<TypeCustomerEntity> typesCustomer = [];
  List<UserEntity> users = [];
  TypeCustomerEntity? typeCustomerSelected;
  UserEntity? recoverySelected;

  AddCustomerManageDataController({
    required this.addCustomerController,
    required this.getTypesCustomerUseCase,
    required this.getUsersUseCase,
  });

  AddCustomerUi get ui => addCustomerController.ui;

  @override
  void onReady() {
    getAssignedRecovery(initialValue: ui.idAssignedRecoveryAgent?.value);
    getTypesCustomer(initialValue: ui.idTypeCustomer?.value);
    super.onReady();
  }

  void getAssignedRecovery({int? initialValue}) async {
    showLoading();
    Result<List<UserEntity>> resultType = await getUsersUseCase.execute();
    hideLoading();
    final data = executeResultUI<List<UserEntity>>(resultType);
    if (data != null) {
      users = data;
      if (initialValue != null) {
        onChangedAssignedRecovery(initialValue);
      }
    }
    update([assignedRecoveryIdGet]);
  }

  void getTypesCustomer({int? initialValue}) async {
    showLoading();
    Result<List<TypeCustomerEntity>> resultType =
        await getTypesCustomerUseCase.execute();
    hideLoading();
    final data = executeResultUI<List<TypeCustomerEntity>>(resultType);
    if (data != null) {
      typesCustomer = data;
      if (typesCustomer.isNotEmpty) {
        onChangedTypeCustomer(initialValue ?? typesCustomer.first.id);
      }
    }
    update([typesCustomerIdGet]);
  }

  void onChangedTypeCustomer(dynamic value) {
    int index = typesCustomer.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      typeCustomerSelected = typesCustomer[index];
      ui.idTypeCustomer = ValidateResult.initialize(
        label: typeCustomerString,
        value: value,
      );
    }
    update([typesCustomerIdGet]);
  }

  void onChangedAssignedRecovery(dynamic value) {
    int index = users.indexWhere(
      (e) => e.id == value,
    );
    if (index != notFoundPosition) {
      recoverySelected = users[index];
      ui.idAssignedRecoveryAgent = ValidateResult.initialize(
        label: assignedRecoveryAgentString,
        value: value,
      );
    }
    update([assignedRecoveryIdGet]);
  }

  String? validate() {
    return findErrorInValidations([
      ui.idTypeCustomer,
      ui.idAssignedRecoveryAgent,
    ])?.error;
  }
}
