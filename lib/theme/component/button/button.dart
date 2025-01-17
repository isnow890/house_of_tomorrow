import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/asset_icon.dart';

part 'button_size.dart';
part 'button_type.dart';

class Button extends ConsumerStatefulWidget {
  const Button({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.width,
    ButtonType? type,
    ButtonSize? size,
    bool? isInactive,
  })  : type = type ?? ButtonType.fill,
        size = size ?? ButtonSize.medium,
        isInactive = isInactive ?? false;

  /// 클릭 이벤트
  final void Function() onPressed;

  /// Button 타입 & 크기
  final ButtonType type;
  final ButtonSize size;

  /// 비활성화 여부
  final bool isInactive;

  /// 텍스트 & 아이콘
  final String? text;
  final String? icon;

  /// 폭
  final double? width;

  /// 커스텀 색상
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  ConsumerState<Button> createState() => _ButtonState();
}

class _ButtonState extends ConsumerState<Button> {
  /// 버튼이 눌려있는지 여부
  bool isPressed = false;

  /// 비활성화 여부
  bool get isInactive => isPressed || widget.isInactive;

  /// Text & Icon Color
  Color get color => widget.type.getColor(
        context,
        ref,
        isInactive,
        widget.color,
      );

  /// Background Color
  Color get backgroundColor => widget.type.getBackgroundColor(
        context,
        ref,
        isInactive,
        widget.backgroundColor,
      );

  /// Border
  Border? get border => widget.type.getBorder(
        context,
        ref,
        isInactive,
        widget.borderColor,
      );

  /// 버튼 클릭 이벤트
  void onPressed(bool newIsPressed) {
    if (isPressed == newIsPressed) return;
    setState(() {
      isPressed = newIsPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    return GestureDetector(
      /// Click Event
      onTapUp: (details) {
        onPressed(false);
        if (!widget.isInactive) {
          widget.onPressed();
        }
      },
      onTapDown: (details) => onPressed(true),
      onTapCancel: () => onPressed(false),

      /// Container
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: border,
        ),
        padding: EdgeInsets.all(widget.size.padding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Icon
            if (widget.icon != null)
              AssetIcon(
                widget.icon!,
                color: color,
              ),

            /// Gap
            if (widget.icon != null && widget.text != null)
              const SizedBox(width: 8),

            /// Text
            if (widget.text != null)
              Text(
                widget.text!,
                style: widget.size.getTextStyle(context,ref).copyWith(
                      color: color,
                      fontWeight: theme.typo.semiBold,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
