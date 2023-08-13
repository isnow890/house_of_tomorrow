import 'package:apple_store/4-riverpod/state/riverpod_badge.dart';
import 'package:apple_store/common/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = NotifierProvider<RiverPodCart, List<Product>>(() {
  return RiverPodCart();
});

class RiverPodCart extends Notifier<List<Product>> {
  @override
  build() {
    return const [];
  }

  //상품 클릭
  void onProductPressed(Product product) {
    //state 참조를 바꾸지 않으므로 watch 안됨.
    if (state.contains(product)) {
      state =  state.where((element) => element!= product).toList();
      // state =  [...state];
      // state.remove(product);
      // state.remove(product);
    } else {

      state =  [...state,product];
      // state.add(product);


      // ref.watch(badgeProvider.notifier).addBadge(state.length);

    }
  }
}
