import 'package:airnav_helpdesk/modules/faq/faq_controller.dart';
import 'package:airnav_helpdesk/modules/faq/faq_page.dart';
import 'package:airnav_helpdesk/modules/ticket/add_ticket_controller.dart';
import 'package:airnav_helpdesk/modules/ticket/detail/detail_ticket_controller.dart';
import 'package:airnav_helpdesk/modules/ticket/detail/detail_ticket_page.dart';
import 'package:get/get.dart';
import 'main_controller.dart';
import 'modules/dashboard/dashboard_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(()=>AddTicketController());
    Get.lazyPut(()=>FaqController());
  }
}