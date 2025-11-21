import 'package:get/get.dart';

import '../../main_binding.dart';
import '../../main_page.dart';
import '../../modules/dashboard/dashboard_page.dart';
import '../../modules/faq/faq_binding.dart';
import '../../modules/faq/faq_page.dart';
import '../../modules/ticket/add_ticket_binding.dart';
import '../../modules/ticket/add_ticket_page.dart';
import '../../modules/ticket/detail/detail_ticket_binding.dart';
import '../../modules/ticket/detail/detail_ticket_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Path.MAIN,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Path.DASHBOARD,
      page: () => DashboardPage(),
    ),
    GetPage(
      name: _Path.TICKET_DETAIL,
      page: () => const DetailTicketPage(),
      binding: DetailTicketBinding(),
    ),
    GetPage(
      name: _Path.ADD_TICKET,
      page: () => const AddTicketPage(),
      binding: AddTicketBinding(),
    ),
    GetPage(
      name: _Path.FAQ,
      page: () => const FaqPage(),
      binding: FaqBinding(),
    ),
  ];
}
