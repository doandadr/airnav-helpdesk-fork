import 'package:get/get.dart';
import 'assign_ticket_controller.dart';

class AssignTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignTicketController>(() => AssignTicketController());
  }
}
