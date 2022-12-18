import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/language/model/language.dart';

class LanguagePreferences {
  SharedPreferences preferences;
  LanguagePreferences({required this.preferences});

  final StreamController<Language> _controller = StreamController();
  final String key = "language_code";
  Stream<Language> get stream => _controller.stream;

  set language(Language language) {
    String code;
    switch (language) {
      case Language.pt:
        code = 'pt';
        break;
      case Language.en:
        code = 'en';
        break;
      case Language.es:
        code = 'es';
        break;
    }
    preferences.setString(key, code);
    _controller.sink.add(language);
  }

  Language get language {
    String? code = preferences.getString(key);
    if (code == null) {
      preferences.setString(key, 'en');
      return Language.en;
    }
    if (code == Language.en.name) {
      return Language.en;
    } else if (code == Language.es.name) {
      return Language.es;
    } else if (code == Language.pt.name) {
      return Language.pt;
    }
    throw Exception("Invalid language");
  }
}
