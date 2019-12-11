import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context, listen: false);
    final cart = cartData.cartItemsList;
    final cartCount = cartData.cartItemCount;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        cartData.totalQuantity.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Chip(
                      label: Text(
                        '\$${cartData.amount.toString()}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) => CartItemWidget(
                  cart[index].title,
                  cart[index].imageUrl,
                  cart[index].price,
                  cart[index].quantity,
                ),
                itemCount: cartCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
