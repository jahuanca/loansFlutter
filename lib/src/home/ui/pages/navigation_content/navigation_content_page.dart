import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/customers/ui/pages/customers/customers_page.dart';
import 'package:loands_flutter/src/home/ui/pages/dashboard/dashboard_page.dart';
import 'package:loands_flutter/src/home/ui/pages/home_calendar/home_calendar_page.dart';
import 'package:loands_flutter/src/home/ui/pages/navigation_content/navigation_content_controller.dart';
import 'package:loands_flutter/src/loans/ui/pages/loans/loans_page.dart';
import 'package:loands_flutter/src/settings/ui/home_settings/home_settings_page.dart';
import 'package:utils/utils.dart';

class NavigationContentPage extends StatelessWidget {
  final NavigationContentController controller = NavigationContentController();

  final PageController pageController = PageController();

  final List<BottomNavigationItemWidget> _iconsOfBottom = [
    BottomNavigationItemWidget(icon: Icons.home, title: 'Inicio'),
    BottomNavigationItemWidget(icon: Icons.calendar_month, title: 'Calendario'),
    BottomNavigationItemWidget(
        icon: Icons.shopping_bag_outlined, title: 'Préstamos'),
    BottomNavigationItemWidget(icon: Icons.people, title: 'Clientes'),
    BottomNavigationItemWidget(icon: Icons.settings, title: 'Ajustes'),
  ];

  final List<Widget> _pages = [
    DashboardPage(),
    HomeCalendarPage(),
    LoansPage(),
    CustomersPage(),
    const HomeSettingsPage(),
  ];

  NavigationContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationContentController>(
      init: NavigationContentController(),
      id: pageIdGet,
      builder: (controller) => Scaffold(
        body: _body(),
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }

  Widget _body() => PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      );

  Widget _bottomNavigation() => GetBuilder<NavigationContentController>(
    id: pageIdGet,
    builder: (controller)=> BottomNavigationBarWidget(
          icons: _iconsOfBottom,
          onTapItem: (index) {
            pageController.jumpToPage(index);
            controller.onChangedPage(index);
          },
          indexSelectedItem: controller.indexPage,
        ),
  );
}
