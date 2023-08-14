import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:house_of_tomorrow/router/go_router.dart';
import 'package:house_of_tomorrow/src/service/lang_service.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/src/view/shopping/shopping_view.dart';
import 'package:house_of_tomorrow/theme/component/constrained_screen.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:flutter_web_plugins/url_strategy.dart';


// import 'generated/l10n.dart';

void main() async {
  usePathUrlStrategy();

  // final strings = await S.load(Locale.fromSubtags(languageCode: 'en')); // mimic localization delegate init
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeServiceProvider);
    final route = ref.watch(goRouterProvider);

    // Modular.setNavigatorKey(navigatorKey);

    return Center(
      child: ConstrainedScreen(
        child: MaterialApp.router(
          builder: (context, child) {
            return Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => child!,
                )
              ],
            );
          },
          routerConfig: route,
          locale: ref.watch(langServiceProvider),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ref.read(themeServiceProvider.notifier).themeData,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
