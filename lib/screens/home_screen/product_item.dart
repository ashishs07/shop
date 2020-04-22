import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../models/product.dart';

import '../../screens/product_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        child: GridTile(
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(product.title),
            subtitle: Text('\$${product.price}'),
            leading: _buildFooterLeading(context, product),
            trailing: _buildFooterTrailing(context, product),
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductScreen.routeName, arguments: product);
        },
      ),
    );
  }

  Widget _buildFooterLeading(BuildContext context, Product product) {
    return IconButton(
      icon: Icon(Icons.favorite),
      onPressed: () {},
    );
  }

  Widget _buildFooterTrailing(BuildContext context, Product product) {
    return Consumer<CartProvider>(
      builder: (ctx, cartData, _) => IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: () {
          cartData.addToCart(
            productId: product.id,
            imageUrl: product.imageUrl,
            title: product.title,
            price: double.parse(product.price),
          );
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Item added Successfully!!'),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  cartData.undoAction(product.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
