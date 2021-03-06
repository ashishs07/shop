import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../../models/product.dart';
import './product_item.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<List<Product>>(
          stream: Provider.of<ProductsProvider>(context).getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final products = snapshot.data;
              return GridView.builder(
                itemCount: products.length,
                itemBuilder: (ctx, index) => ProductItem(products[index]),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
