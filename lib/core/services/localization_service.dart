import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService extends GetxService {
  final _box = GetStorage();
  final _key = 'locale';

  // Default locale
  static const locale = Locale('en', 'US');
  static const fallbackLocale = Locale('en', 'US');

  // Supported locales
  static final locales = [const Locale('en', 'US'), const Locale('id', 'ID')];

  // Keys for translations
  static final langs = ['English', 'Indonesia'];

  // Get current locale from storage or default
  Locale get currentLocale {
    final storedLocale = _box.read(_key);
    if (storedLocale != null) {
      final parts = storedLocale.split('_');
      return Locale(parts[0], parts[1]);
    }
    return locale;
  }

  // Change locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    if (locale != null) {
      Get.updateLocale(locale);
      _box.write(_key, '${locale.languageCode}_${locale.countryCode}');
    }
  }

  // Helper to get Locale from language name
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
