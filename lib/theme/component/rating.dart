import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/asset_icon.dart';

class Rating extends ConsumerWidget {
  const Rating({
    super.key,
    required this.rating,
  });

  final String rating;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AssetIcon(
          'star',
          color: theme.color.tertiary,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          rating,
          style: theme.typo.body1.copyWith(
            fontWeight: theme.typo.light,
            color: theme.color.subtext,
          ),
        ),
      ],
    );
  }
}