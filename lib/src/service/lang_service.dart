import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';


final langServiceProvider = NotifierProvider<LangService,Locale>(()=>LangService());

class LangService extends Notifier<Locale> {
  @override
  Locale build() {
    return IntlHelper.en;
  }

  void toggleLang() {
    state = IntlHelper.isKo ? IntlHelper.en : IntlHelper.ko;
  }
}
