import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

class ColorPicker extends ConsumerWidget {
  const ColorPicker({
    super.key,
    required this.colorIndex,
    required this.colorList,
    required this.onColorSelected,
  });

  final int colorIndex;
  final List<Color> colorList;
  final void Function(int index) onColorSelected;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Wrap(
      spacing: 16,
      alignment: WrapAlignment.center,
      children: colorList.asMap().entries.map((entry) {
        int index = entry.key;
        Color color = entry.value;
        bool isSelected = colorIndex == index;
        return GestureDetector(
          onTap: () => onColorSelected(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 222),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                color: theme.color.primary,
                width: 3,
              )
                  : null,
              borderRadius: BorderRadius.circular(99),
            ),
            padding: EdgeInsets.all(isSelected ? 1 : 4),
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: theme.deco.shadow,
              ),
              child: CircleAvatar(
                backgroundColor: color,
                radius: 20,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}