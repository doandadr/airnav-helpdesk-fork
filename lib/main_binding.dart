import 'package:airnav_helpdesk/modules/dashboard/dashboard_controller.dart';
import 'package:airnav_helpdesk/modules/menu/menu_controller.dart' as menu_ctrl;
import 'package:airnav_helpdesk/modules/ticket/list/ticket_list_controller.dart';
import 'package:get/get.dart';

import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<TicketListController>(() => TicketListController());
    Get.lazyPut<menu_ctrl.MenuController>(() => menu_ctrl.MenuController());
  }
}
