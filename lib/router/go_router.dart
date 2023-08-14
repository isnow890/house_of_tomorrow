import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:house_of_tomorrow/src/view/cart/cart_view.dart';
import 'package:house_of_tomorrow/src/view/product/product_view.dart';
import 'package:house_of_tomorrow/src/view/shopping/shopping_view.dart';

import '../src/model/product.dart';


final goRouterProvider = Provider<GoRouter>((ref) {
  //watch - 값이 변경될때마다 다시 빌드
  //read - 한번만 읽고 값이 변경돼도 다시 빌드하지 않음
  // final provider = ref.read(goRouterRedirectionProvider);

  return GoRouter(
    initialLocation: '/shoppingView',
    routes: routes,
    navigatorKey: navigatorKey
  );
});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

List<GoRoute> get routes => [
      GoRoute(
          path: '/shoppingView',
          name: ShoppingView.routeName,
          builder: (context, state) => const ShoppingView()),
      GoRoute(
        path: '/productView',
        name: ProductView.routeName,
        builder: (context, state) {
          final product = state.extra as Product;
          return ProductView(product: product);

// return ProductView(product: state.uri.queryParameters['']);
        },
      ),
      GoRoute(
          path: '/cartView',
          name: CartView.routeName,
          builder: (context, state) => const CartView()),
    ];
