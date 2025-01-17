import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/asset_icon.dart';

class CounterButton extends ConsumerWidget {
  const CounterButton({
    super.key,
    required this.count,
    required this.onChanged,
  });

  final int count;
  final void Function(int count) onChanged;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    bool isMinusActive = count > 1;
    final theme = ref.watch(themeServiceProvider);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      children: [
        /// Minus
        GestureDetector(
          onTap: () {
            if (!isMinusActive) return;
            onChanged(count - 1);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 222),
            decoration: BoxDecoration(
              color: theme.color.surface,
              boxShadow: isMinusActive ? theme.deco.shadow : null,
              borderRadius: BorderRadius.circular(99),
            ),
            padding: const EdgeInsets.all(8),
            child: AssetIcon(
              'minus',
              color: isMinusActive
                  ? theme.color.primary
                  : theme.color.inactive,
            ),
          ),
        ),

        /// Counter
        Text(
          '$count',
          style: theme.typo.headline4.copyWith(
            fontWeight: theme.typo.semiBold,
          ),
        ),

        /// Plus
        GestureDetector(
          onTap: () => onChanged(count + 1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 222),
            decoration: BoxDecoration(
              color: theme.color.surface,
              boxShadow: theme.deco.shadow,
              borderRadius: BorderRadius.circular(99),
            ),
            padding: const EdgeInsets.all(8),
            child: AssetIcon(
              'plus',
              color: theme.color.primary,
            ),
          ),
        ),
      ],
    );
  }
}