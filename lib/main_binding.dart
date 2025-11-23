import 'package:airnav_helpdesk/modules/faq/faq_controller.dart';
import 'package:get/get.dart';
import 'main_controller.dart';
import 'modules/dashboard/dashboard_controller.dart';
import 'modules/menu/menu_controller.dart';
import 'modules/ticket/list/ticket_list_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => TicketListController());
    Get.lazyPut(() => FaqController());
    Get.lazyPut(() => MenuController());
  }
}
