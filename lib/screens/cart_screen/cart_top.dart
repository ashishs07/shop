import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';
import '../../models/cart_item.dart';

class CartTopCard extends StatefulWidget {
  @override
  _CartTopCardState createState() => _CartTopCardState();
}

class _CartTopCardState extends State<CartTopCard> {
  var _ordering = false;

  Future<void> _orderNow() async {
    setState(() {
      _ordering = true;
    });

    final cart = Provider.of<CartProvider>(context, listen: false);
    final cartItemsData = await cart.getCartItemsData();

    await Provider.of<OrdersProvider>(context, listen: false).placeOrder({
      'totalAmount': cartItemsData['amount'],
      'cartItems': cartItemsData['quantity'],
      'date': DateTime.now().toIso8601String(),
    }, (cartItemsData['list'] as List<CartItem>));

    await cart.clearCart();
    setState(() {
      _ordering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            /* Chip(
              label: Text(
                '\$${widget.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ), */
            SizedBox(width: 10),
            _ordering
                ? CircularProgressIndicator()
                : FlatButton(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: _orderNow,
                  ),
          ],
        ),
      ),
    );
  }
}
