import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/rating.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';

import '../../product/product_view.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return GestureDetector(
      onTap: () => context.pushNamed(ProductView.routeName, extra: product),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.color.surface,
          boxShadow: theme.deco.shadow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            if (product.productColorList.isNotEmpty)
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(16),
              //   child: Image.network(
              //     product.productColorList.first.imageUrl,
              //     fit: BoxFit.cover,
              //   ),
              // ),

              AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: product.productColorList.first.imageUrl,
                  ),
                ),
              ),

            const SizedBox(height: 4),

            /// Name
            Text(
              product.name.toString(),
              style: theme.typo.headline4.copyWith(
                fontWeight: theme.typo.semiBold,
              ),
            ),
            const SizedBox(height: 4),

            /// Brand
            Text(
              product.brand.toString(),
              style: theme.typo.body2.copyWith(
                fontWeight: theme.typo.light,
                color: theme.color.subtext,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                /// Price
                Expanded(
                  child: Text(
                    IntlHelper.currency(
                      number: product.price,
                      symbol: product.priceUnit,
                    ),
                    style: theme.typo.subtitle2,
                  ),
                ),

                /// Rating
                Rating(rating: product.rating),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
