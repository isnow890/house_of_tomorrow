import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';

class InputField extends ConsumerStatefulWidget {
  const InputField({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  final String? hint;
  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final void Function()? onClear;

  @override
  ConsumerState<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends ConsumerState<InputField> {

  late final TextEditingController controller =
      widget.controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    return TextField(
      controller: controller,

      /// 텍스트 변경시
      onChanged: (value) {
        setState(() {});
        widget.onChanged?.call(value);
      },

      /// 엔터 누를 때
      onSubmitted: widget.onSubmitted,

      /// 텍스트 스타일
      style: theme.typo.headline5,

      /// 커서 색상
      cursorColor: theme.color.primary,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          /// 테두리 삭제
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),

          /// 테두리 둥글게
          borderRadius: BorderRadius.circular(12),
        ),

        /// 배경 색상
        filled: true,
        fillColor: theme.color.hintContainer,

        /// 힌트 스타일
        hintStyle: theme.typo.headline5.copyWith(
          fontWeight: theme.typo.light,
          color: theme.color.onHintContainer,
        ),
        hintText: widget.hint,

        /// padding
        contentPadding: const EdgeInsets.symmetric(
          vertical: 11.5,
          horizontal: 16,
        ),

        /// 삭제 버튼
        suffixIcon: controller.text.isEmpty
            ? null
            : Button(
          icon: 'close',
          type: ButtonType.flat,
          onPressed: () {
            setState(() {
              controller.clear();
              widget.onClear?.call();
            });
          },
        ),
      ),
    );
  }
}