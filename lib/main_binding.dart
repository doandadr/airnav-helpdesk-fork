import 'package:get/get.dart';
import 'main_controller.dart';
import 'modules/dashboard/dashboard_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => DashboardController());
  }
}