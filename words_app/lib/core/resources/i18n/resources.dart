import 'package:flutter/widgets.dart';
import './strings/strings.dart';

class R {
  static Translation strings = EnUs();

  static void load(Locale locale) {
    switch (locale.toString()) {
      case 'en_US':
        strings = EnUs();
        break;
      case 'pt_BR':
        //strings = PtBr();
        strings = EnUs();
        break;
      default:
        strings = EnUs();
        break;
    }
  }
}
