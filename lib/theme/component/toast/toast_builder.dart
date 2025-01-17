import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

// final isShowProvider = StateProvider((ref) => false);

class ToastBuilder extends ConsumerStatefulWidget {
  const ToastBuilder({
    super.key,
    required this.text,
    required this.animDuration,
  });

  final String text;
  final Duration animDuration;

  @override
  ConsumerState<ToastBuilder> createState() => ToastBuilderState();
}

class ToastBuilderState extends ConsumerState<ToastBuilder> {


  bool _isShow = false;

  bool get isShow => _isShow;

  set isShow(bool value) {
    setState(() {
      _isShow = value;
    });
  }



  @override
  Widget build(

  BuildContext context,
  ) {

    final Size screenSize = MediaQuery.of(context).size;
    final theme = ref.watch(themeServiceProvider);
    return Positioned(
      bottom: screenSize.height * 0.25,
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedOpacity(
          opacity: isShow ? 1 : 0,
          duration: widget.animDuration,
          child: Container(
            decoration: BoxDecoration(
              color: theme.color.toastContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: DefaultTextStyle(
              style: theme.typo.headline6.copyWith(
                color: theme.color.onToastContainer,
              ),
              child: Text(widget.text),
            ),
          ),
        ),
      ),
    );
  }
}
