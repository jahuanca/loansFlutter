import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/di/customer_analytics_binding.dart';
import 'package:loands_flutter/src/customers/domain/entities/customer_entity.dart';
import 'package:loands_flutter/src/customers/ui/pages/customer_analytics/customer_analytics_page.dart';
import 'package:loands_flutter/src/home/di/navigation_content_binding.dart';
import 'package:loands_flutter/src/home/di/quota_group_binding.dart';
import 'package:loands_flutter/src/home/ui/pages/navigation_content/navigation_content_page.dart';
import 'package:loands_flutter/src/home/ui/pages/quota_group/quota_group_page.dart';
import 'package:loands_flutter/src/loans/data/requests/get_quotas_by_date_request.dart';
import 'package:loands_flutter/src/login/di/login_binding.dart';
import 'package:loands_flutter/src/login/ui/pages/back_to_sesion/back_to_sesion_page.dart';
import 'package:loands_flutter/src/utils/core/default_values_of_app.dart';
import 'package:loands_flutter/src/utils/core/strings_arguments.dart';
import 'package:utils/utils.dart';

class RoutesApp {
  static Future<dynamic> goToBackToSesion({
    TypeMovementRoute type = TypeMovementRoute.to,
  }) async {
    return await _returnValue(
      type: type,
      page: BackToSesionPage(),
      binding: LoginBinding(),
    );
  }

  static Future<dynamic> goToNavigationContent({
    TypeMovementRoute type = TypeMovementRoute.to,
  }) async {
    return await _returnValue(
      type: type,
      page: NavigationContentPage(),
      binding: NavigationContentBinding(),
    );
  }

  static Future<dynamic> goCustomerAnalytics({
    required CustomerEntity customerSelected,
  }) async {
    await Get.to(() => CustomerAnalyticsPage(),
        binding: CustomerAnalyticsBinding(),
        arguments: {customerArgument: customerSelected});
  }

  static Future<dynamic> goPendingQuotas() async {
    GetQuotasByDateRequest request = GetQuotasByDateRequest(
      idStateQuota: idOfPendingQuota,
      untilDate: defaultDate,
    );

    return await _returnValue(
        type: TypeMovementRoute.offAll,
        page: QuotaGroupPage(),
        binding: QuotaGroupBinding(),
        arguments: {
          getAllQuotasRequestArgument: request,
          titleArgument: 'Cuotas vencidas',
          isGroupArgument: false,
          originArgument: OriginsRoute.login,
        });
  }
}

enum TypeMovementRoute { to, off, offAll }

enum OriginsRoute {
  login, 
}

Future<void> _returnValue({
  required TypeMovementRoute type,
  required Widget page,
  required Bindings binding,
  Map<String, dynamic>? arguments,
}) async {
  switch (type) {
    case TypeMovementRoute.to:
      return await Get.to(() => page, binding: binding, arguments: arguments);
    case TypeMovementRoute.off:
      return await Get.off(() => page, binding: binding, arguments: arguments);
    case TypeMovementRoute.offAll:
      return await Get.offAll(() => page,
          binding: binding, arguments: arguments);
  }
}
