import 'package:airnav_helpdesk/modules/faq/faq_page.dart';
import 'package:airnav_helpdesk/modules/ticket/add_ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'main_controller.dart';
import 'modules/dashboard/dashboard_page.dart';
import 'modules/menu/menu_page.dart';
import 'modules/ticket/ticket_page.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  List<Widget> _screens() => [
    DashboardPage(),
    TicketPage(),
    MenuPage(),
    AddTicketPage(),
    // FaqPage()
  ];

  List<PersistentBottomNavBarItem> _items() => [

    PersistentBottomNavBarItem(
      icon: const Icon(Icons.dashboard),
      title: 'Dashboard',
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.airplane_ticket_outlined), // TODO change to lucide ticket
      title: 'Ticket',
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.menu),
      title: 'Menu',
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.add_circle_outline),
      title: 'Submit Ticket',
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey.shade400,
    ),
    // PersistentBottomNavBarItem(
    //   icon: const Icon(Icons.question_mark),
    //   title: 'FAQ',
    // ),
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
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      stateManagement: false,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
    );
  }
}
