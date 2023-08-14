import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/rating.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ProductDesc extends ConsumerWidget {
  const ProductDesc({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final theme = ref.watch(themeServiceProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          /// Title
          Row(
            children: [
              Expanded(
                child: Text(
                  S.current.description,
                  style: theme.typo.headline4.copyWith(
                    fontWeight: theme.typo.semiBold,
                  ),
                ),
              ),

              /// Rating
              Rating(rating: product.rating),
            ],
          ),

          const SizedBox(height: 24),

          /// Content
          Text(
            product.desc.toString(),
            style: theme.typo.headline6.copyWith(
              color: theme.color.subtext,
            ),
          ),
        ],
      ),
    );
  }
}