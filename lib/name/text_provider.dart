import 'package:flutter/material.dart';

class TextProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  String get title =>
      _locale.languageCode == 'en' ? 'Demo Provider' : 'مزود التجريبي';

  Locale get locale => _locale;

  void toggleLocale() {
    _locale =
        _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }
}
