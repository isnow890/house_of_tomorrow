import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_card.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_card_grid.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_empty.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/theme/component/cart_button.dart';
import 'package:house_of_tomorrow/theme/component/hide_keyboard.dart';

import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

import '../../../theme/component/bottom_sheet/base_bottom_sheet.dart';
import '../../../theme/component/input_field.dart';
import '../../../util/helper/network_helper.dart';

class ShoppingView extends ConsumerStatefulWidget {
  const ShoppingView({super.key});

  static String get routeName => 'shoppingView';

  @override
  ConsumerState<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends ConsumerState<ShoppingView> {
  List<Product> productList = [];
  final TextEditingController textController = TextEditingController();

  String get keyword => textController.text.trim();

  Future<void> searchProductList() async {
    try {
      final res = await NetworkHelper.dio.get(
        'https://gist.githubusercontent.com/nero-angela/d16a5078c7959bf5abf6a9e0f8c2851a/raw/04fb4d21ddd1ba06f0349a890f5e5347d94d677e/ikeaSofaDataIBB.json',
      );

      setState(() {
        productList = jsonDecode(res.data).map<Product>((json) {
          return Product.fromJson(json);
        }).where((product) {
          /// 키워드가 비어있는 경우 모두 반환
          if (keyword.isEmpty) return true;

          /// name이나 brand에 키워드 포함 여부 확인
          return "${product.name}${product.brand}"
              .toLowerCase()
              .contains(keyword.toLowerCase());
        }).toList();
      });
    } catch (e, s) {
      log('Failed to searchProductList', error: e, stackTrace: s);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchProductList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);
    // context.read<ThemeService>().toggleTheme

    //context.watch<ThemeService>().theme.typo.headline6

    return HideKeyboard(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.shopping),
          actions: [
            Button(
              icon: 'option',
              type: ButtonType.flat,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const SettingBottomSheet();
                  },
                );
              },
            ),
            const CartButton(),
          ],
        ),
        // backgroundColor: theme.color.surface,

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: [
                  /// 검색
                  Expanded(
                    child: InputField(
                      controller: textController,
                      onClear: () async {
                        await searchProductList();
                      },
                      onSubmitted: (text) {
                        searchProductList();
                      },
                      hint: S.current.searchProduct,
                    ),
                  ),
                  const SizedBox(width: 16),

                  /// 검색 버튼
                  Button(
                    icon: 'search',
                    onPressed: () {
                      searchProductList();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: productList.isEmpty
                  ? ProductEmpty()
                  : ProductCardGrid(productList),
            ),
          ],
        ),
      ),
    );
  }
}
