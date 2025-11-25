import 'package:airnav_helpdesk/modules/ticket/list/ticket_list_controller.dart';
import 'package:get/get.dart';

class TicketListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketListController>(() => TicketListController());
  }
}
