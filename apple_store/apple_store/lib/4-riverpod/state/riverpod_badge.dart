import 'package:apple_store/4-riverpod/state/riverpod_cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final badgeProvider = NotifierProvider<RiverpodBadge, int>(RiverpodBadge.new);

class RiverpodBadge extends Notifier<int> {
  @override
  int build() {

    final cart = ref.watch(cartProvider);


    print('실행');
    // TODO: implement build
    // return cart.length;
    return cart.length ;
  }


  void addBadge(int count){
    print('실행실행');
    state = count;
    print(state);
  }
}
