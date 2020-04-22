import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import './cart_item.dart';
import './cart_top.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CartTopCard(
              cartData.totalQuantity,
              cartData.amount,
            ),
            if (cartData.cartItemCount == 0)
              Text('Your Shopping cart is Empty!!'),
            cartData.cartItemCount != 0
                ? Expanded(
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
                  )
                : RaisedButton.icon(
                    label: Text('Go to Home Page'),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.reorder,
                      size: 30,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
