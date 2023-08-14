import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';

class ProductColorPreview extends ConsumerWidget {
  const ProductColorPreview({
    super.key,
    required this.colorIndex,
    required this.product,
  });

  final int colorIndex;
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Container(
      decoration: BoxDecoration(
        color: theme.color.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: theme.deco.shadow,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          AspectRatio(
            aspectRatio: 1 / 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: product.productColorList[colorIndex].imageUrl,
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Name
          Text(
            product.name.toString(),
            style: theme.typo.headline1.copyWith(
              fontWeight: theme.typo.semiBold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              /// Brand
              Text(
                product.brand.toString(),
                style: theme.typo.subtitle1.copyWith(
                  fontWeight: theme.typo.light,
                  color: theme.color.subtext,
                ),
              ),

              const Spacer(),

              /// Price
              Text(
                IntlHelper.currency(
                  symbol: product.priceUnit,
                  number: product.price,
                ),
                style: theme.typo.headline6.copyWith(
                  color: theme.color.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
