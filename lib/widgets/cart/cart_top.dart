import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';

class CartTopCard extends StatelessWidget {
  final int totalQuantity;
  final double totalAmount;

  CartTopCard(this.totalQuantity, this.totalAmount);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(width: 1),
            Text(
              'Total',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            Spacer(),
            SizedBox(width: 15),
            Chip(
              label: Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 10),
            FlatButton(
              padding: const EdgeInsets.all(10),
              child: Text(
                'ORDER NOW',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Provider.of<OrderProvider>(context, listen: false)
                    .addOrder(totalAmount, cartData.cartItemsList);
                cartData.clearCart();
              },
            ),
          ],
        ),
      ),
    );
  }
}
