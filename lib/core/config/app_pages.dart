import 'package:get/get.dart';

import '../../main_binding.dart';
import '../../main_page.dart';
import '../../modules/dashboard/dashboard_page.dart';
import '../../modules/dashboard/detail/dashboard_detail_binding.dart';
import '../../modules/dashboard/detail/dashboard_detail_page.dart';

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
      name: _Path.DASHBOARD_DETAIL,
      page: () => const DashboardDetailPage(),
      binding: DashboardDetailBinding(),
    ),
  ];
}
