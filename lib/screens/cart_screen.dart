import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

import '../widgets/cart_top.dart';
import '../widgets/cart_item.dart';
import '../widgets/drawer_global.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  static const pageName = 'My Cart';
  static const pageIcon = Icons.shopping_cart;

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    final cart = cartData.cartItemsList;
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
      ),
      drawer: DrawerGlobal(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CartTopCard(
              cartData.totalQuantity,
              cartData.amount,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) => CartItemWidget(
                  cartData.cartItems.keys.toList()[index],
                  cart[index].title,
                  cart[index].imageUrl,
                  cart[index].price,
                  cart[index].quantity,
                ),
                itemCount: cartData.cartItemCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
