import 'package:airnav_helpdesk/placeholder_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'main_controller.dart';
import 'modules/dashboard/dashboard_page.dart';


class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  List<Widget> _screens() => [
    const APage(),
    const BPage(),
    DashboardPage()
  ];

  List<PersistentBottomNavBarItem> _items() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.abc),
      title: 'A',
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.abc_rounded),
      title: 'B',
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.dashboard),
      title: 'Dashboard',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.tabController,
      screens: _screens(),
      items: _items(),
      navBarStyle: NavBarStyle.style3,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(12),
        colorBehindNavBar: Colors.white,
      ),
      stateManagement: false, // GetX yang handle state
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
    );
  }
}
