import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/customers/customers_page.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_page.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/home_calendar_page.dart';
import 'package:loands_flutter/src/home/ui/pages/navigation_content/navigation_content_controller.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_page.dart';
import 'package:utils/utils.dart';

class NavigationContentPage extends StatelessWidget {
  final List<BottomNavigationItemWidget> iconsOfBottom = [
    BottomNavigationItemWidget(icon: Icons.home, title: 'Inicio'),
    BottomNavigationItemWidget(icon: Icons.calendar_month, title: 'Calendario'),
    BottomNavigationItemWidget(icon: Icons.shopping_bag_outlined, title: 'Préstamos'),
    BottomNavigationItemWidget(icon: Icons.people, title: 'Clientes'),
  ];

  final List<Widget> pages = [
    DashboardPage(),
    HomeCalendarPage(),
    LoansPage(),
    CustomersPage(),
  ];

  NavigationContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationContentController>(
      init: NavigationContentController(),
      id: pageIdGet,
      builder: (controller) => Scaffold(
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          icons: iconsOfBottom,
          onTapItem: controller.onChangedPage,
          indexSelectedItem: controller.indexPage,
        ),
      ),
    );
  }
}
