import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import 'package:shop/models/cart_item.dart';
import './cart_card.dart';
import './cart_top.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  static const pageName = 'My Cart';
  static const pageIcon = Icons.shopping_cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageName)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            CartTopCard(),
            Expanded(
              child: _buildCartList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartList(BuildContext context) {
    return StreamBuilder<List<CartItem>>(
        stream: Provider.of<CartProvider>(context).getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final cartItems = snapshot.data;
            return ListView.builder(
              itemBuilder: (ctx, index) => CartCard(cartItems[index]),
              itemCount: cartItems.length,
            );
          } else {
            return Text('Your cart is Empty');
          }
        });
  }
}
