
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/utils/core/extensions.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';

class CustomerDetailController extends GetxController {

  late CustomerEntity customer;

  @override
  void onInit() {
    customer = Get.setArgument(customerArgument);
    super.onInit();
  }

}