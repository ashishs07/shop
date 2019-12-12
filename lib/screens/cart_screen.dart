import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

import '../widgets/cart_top.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context, listen: false);
    final cart = cartData.cartItemsList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            CartTopCard(
              cartData.totalQuantity,
              cartData.amount,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) => CartItemWidget(
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
