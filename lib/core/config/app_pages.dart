import 'package:airnav_helpdesk/modules/ticket/ticket_binding.dart';
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
import '../../modules/ticket/ticket_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Path.MAIN,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Path.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Path.TICKET_DETAIL,
      page: () => const DetailTicketPage(),
      binding: DetailTicketBinding(),
    ),
    GetPage(
      name: _Path.TICKET,
      page: () => const TicketPage(),
      binding: TicketBinding(),
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
    GetPage(name: _Path.ONBOARDING, page: () => const OnboardingPage()),
    GetPage(name: _Path.LOGIN, page: () => const LoginPage()),
    GetPage(
      name: _Path.CHATBOT,
      page: () => const ChatbotPage(),
      binding: ChatbotBinding(),
    ),
  ];
}
