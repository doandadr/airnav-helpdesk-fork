part of 'app_pages.dart';

abstract class Routes {
  static const MAIN = _Path.MAIN;
  static const DASHBOARD = _Path.DASHBOARD;
  static const DASHBOARD_DETAIL = _Path.DASHBOARD_DETAIL;
}

abstract class _Path {
  static const MAIN = '/main';
  static const DASHBOARD = '/dashboard';
  static const DASHBOARD_DETAIL = '/dashboard/detail';
}
