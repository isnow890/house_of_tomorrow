import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/src/model/cart_item.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_bottom_sheet.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_color_preview.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_desc.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_layout.dart';
import 'package:house_of_tomorrow/theme/component/cart_button.dart';
import 'package:house_of_tomorrow/theme/component/color_picker.dart';
import 'package:house_of_tomorrow/theme/component/pop_button.dart';
import 'package:house_of_tomorrow/theme/component/toast/toast.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({
    super.key,
    required this.product,
  });

  static String get routeName => 'productView';

  final Product product;

  @override
  ConsumerState<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  /// 선택한 수량
  int count = 1;

  /// 선택한 색상
  int colorIndex = 0;

  /// 수량 업데이트 이벤트 함수
  void onCountChanged(int newCount) {
    setState(() {
      count = newCount;
    });
  }

  /// 색상 업데이트 이벤트 함수
  void onColorIndexChanged(int newColorIndex) {
    setState(() {
      colorIndex = newColorIndex;
    });
  }

  /// 카트에 상품 추가
  void onAddToCartPressed() {
    final cartService = ref.read(cartServiceProvider.notifier);
    final CartItem newCartItem = CartItem(
      colorIndex: colorIndex,
      count: count,
      isSelected: true,
      product: widget.product,
    );
    cartService.add(newCartItem);
    Toast.show(S.current.productAdded(widget.product.name));
  }

  @override
  Widget build(BuildContext context) {
    print('product view');

    return Scaffold(
      appBar: AppBar(
        leading: PopButton(),
        titleSpacing: 0,
        title: Text(S.current.product),
        actions: const [
          CartButton(),
        ],
      ),
      body: ProductLayout(
        productInfo: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Wrap(
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: [
              ProductColorPreview(
                  colorIndex: colorIndex, product: widget.product),
              ColorPicker(
                colorIndex: colorIndex,
                colorList: widget.product.productColorList
                    .map((e) => e.color)
                    .toList(),
                onColorSelected: onColorIndexChanged,
              ),
              ProductDesc(product: widget.product),
            ],
          ),
        ),
        productBottomSheet: ProductBottomSheet(
            count: count,
            product: widget.product,
            onCountChanged: onCountChanged,
            onAddToCartPressed: onAddToCartPressed),
      ),
    );
  }
}
