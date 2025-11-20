import 'package:get/get.dart';
import '../models/help_request.dart';

class DashboardDetailController extends GetxController {
  final helpRequest = Rxn<HelpRequest>();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is HelpRequest) {
      helpRequest.value = args;
    }
  }
}
