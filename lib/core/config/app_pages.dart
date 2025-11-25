import 'package:airnav_helpdesk/modules/menu/menu.binding.dart';
import 'package:airnav_helpdesk/modules/menu/menu_page.dart';
import 'package:get/get.dart';

import '../../main_binding.dart';
import '../../main_page.dart';
import '../../modules/chatbot/chatbot_binding.dart';
import '../../modules/chatbot/chatbot_page.dart';
import '../../modules/dashboard/dashboard_binding.dart';
import '../../modules/dashboard/dashboard_page.dart';
import '../../modules/faq/faq_binding.dart';
import '../../modules/faq/faq_page.dart';
import '../../modules/login/login_page.dart';
import '../../modules/onboarding/onboarding_page.dart';
import '../../modules/ticket/add/add_ticket_binding.dart';
import '../../modules/ticket/add/add_ticket_page.dart';
import '../../modules/ticket/assign/assign_ticket_binding.dart';
import '../../modules/ticket/assign/assign_ticket_page.dart';
import '../../modules/ticket/detail/detail_ticket_binding.dart';
import '../../modules/ticket/detail/detail_ticket_page.dart';
import '../../modules/ticket/list/ticket_list_binding.dart';
import '../../modules/ticket/list/ticket_list_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final INITIAL = Routes.ONBOARDING;

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
      page: () => const TicketListPage(),
      binding: TicketListBinding(),
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
    GetPage(
      name: _Path.MENU,
      page: () => const MenuPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Path.ASSIGN_TICKET,
      page: () => const AssignTicketPage(),
      binding: AssignTicketBinding(),
    ),
  ];
}
