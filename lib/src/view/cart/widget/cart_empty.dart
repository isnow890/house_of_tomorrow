import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class CartEmpty extends ConsumerWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Center(
      child: Text(
        S.current.cartIsEmpty,
        style: theme.typo.headline4.copyWith(
          color: theme.color.inactive,
          fontWeight: theme.typo.light,
        ),
      ),
    );
  }
}