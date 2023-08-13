import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

class ShoppingView extends ConsumerWidget {
  const ShoppingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    // context.read<ThemeService>().toggleTheme

    //context.watch<ThemeService>().theme.typo.headline6

    return Scaffold(
      // backgroundColor: theme.color.surface,
      body: Center(
        child: TextButton(
          onPressed: ref.read(themeServiceProvider.notifier).toggleTheme,
          child: Text(
            "Toggle Theme",
            style: theme.typo.headline6,
          ),
        ),
      ),
    );
  }
}
