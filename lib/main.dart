import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/src/view/shopping/shopping_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});




  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final themeState = ref.watch(themeServiceProvider);

    return  MaterialApp(
      theme : ref.read(themeServiceProvider.notifier).themeData,
      debugShowCheckedModeBanner: false,
      home: ShoppingView()
    );
  }
}
