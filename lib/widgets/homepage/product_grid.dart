import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';

import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool favSelected;

  ProductGrid(this.favSelected);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final productList = favSelected ? productData.favItems : productData.items;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: productList.length,
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: productList[index],
            child: ProductItem(),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
