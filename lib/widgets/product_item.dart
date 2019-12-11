import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_model.dart';
import '../providers/cart_provider.dart';

import '../screens/product_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(product.title),
            subtitle: Text(product.price.toString()),
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () => product.changeFavouriteStatus(),
              ),
            ),
            trailing: Consumer<CartProvider>(
              builder: (ctx, cartData, _) => IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  cartData.addToCart(
                      productId: product.id,
                      imageUrl: product.imageUrl,
                      title: product.title,
                      price: product.price);
                },
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductScreen.routeName, arguments: product.id);
        },
      ),
    );
  }
}
