// lib/modules/ticket/ticket_binding.dart
import 'package:get/get.dart';
import 'ticket_controller.dart';

class TicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketController>(() => TicketController());
  }
}
