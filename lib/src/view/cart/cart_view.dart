import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_bottom_sheet.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_empty.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_item_tile.dart';
import 'package:house_of_tomorrow/theme/component/pop_button.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  static String get routeName => 'cartView';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.cart),
        leading: const PopButton(),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? const CartEmpty()
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final cartItem = cart[index];
                      return CartItemTile(
                        cartItem: cartItem,
                        onPressed: () {
                          print('pressed');
                          ref.read(cartServiceProvider.notifier).update(
                              index,
                              cartItem.copyWith(
                                  isSelected: !cartItem.isSelected));
                        },
                        onCountChanged: (count) {
                          ref
                              .read(cartServiceProvider.notifier)
                              .update(index, cartItem.copyWith(count: count));
                        },
                      );
                    },
                  ),
          ),
          CartBottomSheet(
            totalPrice: cart.isEmpty
                ? '0'
                : IntlHelper.currency(
                    symbol: cart.first.product.priceUnit,
                    number: cart.where((element) => element.isSelected).fold(0,
                        (prev, curr) {
                      return prev + curr.count * curr.product.price;
                    }),
                  ),
            selectedCartItemList:
                cart.where((element) => element.isSelected).toList(),
            onCheckoutPressed: () {},
          ),
        ],
      ),
    );
  }
}