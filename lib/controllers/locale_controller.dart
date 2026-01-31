import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  // Reactive locale
  final Rx<Locale> _locale = const Locale('en').obs;

  // Getter
  Locale get locale => _locale.value;

  // Available locales
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('bn'), // Bengali
    Locale('hi'), // Hindi
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize with system locale if supported
    final systemLocale = Get.deviceLocale;
    if (systemLocale != null &&
        supportedLocales.any(
          (l) => l.languageCode == systemLocale.languageCode,
        )) {
      _locale.value = Locale(systemLocale.languageCode);
    }
  }

  // Set locale
  void setLocale(Locale newLocale) {
    if (supportedLocales.contains(newLocale)) {
      _locale.value = newLocale;
      Get.updateLocale(newLocale);
    }
  }

  // Toggle between locales
  void toggleLocale() {
    final currentIndex = supportedLocales.indexOf(_locale.value);
    final nextIndex = (currentIndex + 1) % supportedLocales.length;
    setLocale(supportedLocales[nextIndex]);
  }

  // Set language by code
  void setLanguage(String languageCode) {
    final locale = supportedLocales.firstWhere(
      (l) => l.languageCode == languageCode,
      orElse: () => const Locale('en'),
    );
    setLocale(locale);
  }

  static String getFlag(String code) {
    switch (code) {
      case 'bn':
        return '🇧🇩'; // Or 🇮🇳 for WB/India Bengali
      case 'hi':
        return '🇮🇳';
      case 'en':
      default:
        return '🇺🇸';
    }
  }

  static String getName(String code) {
    switch (code) {
      case 'bn':
        return 'বাংলা';
      case 'hi':
        return 'हिंदी';
      case 'en':
      default:
        return 'English';
    }
  }
}
