import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/cart_item.dart';
import 'package:house_of_tomorrow/util/helper/immutable_helper.dart';

final cartServiceProvider =
    NotifierProvider<CartService, List<CartItem>>(() => CartService());

class CartService extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    // TODO: implement build
    return const [];
  }

  void add(CartItem newCartItem) {
    print('add 실행');
    state = [...state, newCartItem].toImmutable();
  }

  void update(int selectedIndex, CartItem newCartItem) {
    state = state.asMap().entries.map((entry) {
      return entry.key == selectedIndex ? newCartItem : entry.value;
    }).toList();
  }

  void delete(List<CartItem> deleteList) {
    state = state.where((cartItem) {
      return !deleteList.contains(cartItem);
    }).toImmutable();
  }

  List<CartItem> get selectedCartItemList {
    return state.where((cartItem) {
      return cartItem.isSelected;
    }).toImmutable();
  }
}
