import 'package:get/get.dart';
import 'menu_controller.dart' as menu_ctrl;

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<menu_ctrl.MenuController>(() => menu_ctrl.MenuController());
  }
}