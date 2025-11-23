part of 'app_pages.dart';

abstract class Routes {
  static const MAIN = _Path.MAIN;
  static const DASHBOARD = _Path.DASHBOARD;
  static const TICKET_DETAIL = _Path.TICKET_DETAIL;
  static const ADD_TICKET = _Path.ADD_TICKET;
  static const FAQ = _Path.FAQ;
  static const TICKET = _Path.TICKET;
}

abstract class _Path {
  static const MAIN = '/main';
  static const DASHBOARD = '/dashboard';
  static const TICKET_DETAIL = '/ticket/detail';
  static const ADD_TICKET = '/ticket/add';
  static const FAQ = '/faq';
  static const TICKET = '/ticket';
}
