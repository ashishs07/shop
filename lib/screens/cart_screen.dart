import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

import '../screens/product_overview_screen.dart';

import '../widgets/cart/cart_top.dart';
import '../widgets/cart/cart_item.dart';
import '../widgets/drawer_global.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  static const pageName = 'My Cart';
  static const pageIcon = Icons.shopping_cart;

  void _goToHomePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(ProductOverViewScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    final cart = cartData.cartItemsList;
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => _goToHomePage(context),
          ),
        ],
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
                    onPressed: () => _goToHomePage(context),
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
