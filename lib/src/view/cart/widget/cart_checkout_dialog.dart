import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/base_dialog.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class CartCheckoutDialog extends ConsumerWidget {
  const CartCheckoutDialog({
    super.key,
    required this.onCheckoutPressed,
  });

  final void Function() onCheckoutPressed;

  @override
  Widget build(BuildContext context,WidgetRef ref) {


    final theme = ref.watch(themeServiceProvider);

    return BaseDialog(
      title: S.current.delete,
      content: Text(
        S.current.deleteDialogDesc,
        style: theme.typo.headline6,
      ),
      actions: [
        /// Delete
        Button(
          text: S.current.checkout,
          width: double.infinity,
          color: theme.color.onPrimary,
          backgroundColor: theme.color.primary,
          onPressed: () {
            Navigator.pop(context);
            onCheckoutPressed();
          },
        ),
        const SizedBox(height: 12),

        /// Cancel
        Button(
          text: S.current.cancel,
          width: double.infinity,
          color: theme.color.text,
          borderColor: theme.color.hint,
          type: ButtonType.outline,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}