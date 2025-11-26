part of 'app_pages.dart';

abstract class Routes {
  static const MAIN = _Path.MAIN;
  static const DASHBOARD = _Path.DASHBOARD;
  static const TICKET_DETAIL = _Path.TICKET_DETAIL;
  static const ADD_TICKET = _Path.ADD_TICKET;
  static const FAQ = _Path.FAQ;
  static const TICKET = _Path.TICKET;
  static const ONBOARDING = _Path.ONBOARDING;
  static const CHATBOT = _Path.CHATBOT;
  static const LOGIN = _Path.LOGIN;
  static const ASSIGN_TICKET = _Path.ASSIGN_TICKET;
  static const MENU = _Path.MENU;
  static const WELCOME = _Path.WELCOME;
  static const LANGUAGE_SELECTION = _Path.LANGUAGE_SELECTION;
  static const NOTIFICATION = _Path.NOTIFICATION;
}

abstract class _Path {
  static const MAIN = '/main';
  static const DASHBOARD = '/dashboard';
  static const TICKET_DETAIL = '/ticket/detail';
  static const ADD_TICKET = '/ticket/add';
  static const FAQ = '/faq';
  static const TICKET = '/ticket';
  static const ONBOARDING = '/onboarding';
  static const CHATBOT = '/chatbot';
  static const LOGIN = '/login';
  static const ASSIGN_TICKET = '/ticket/assign';
  static const MENU = '/menu';
  static const WELCOME = '/welcome';
  static const LANGUAGE_SELECTION = '/language-selection';
  static const NOTIFICATION = '/notification';
}
