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

  int cartCount = 0;
  double cartAmount = 0.0;
  List<CartItem> cartItems = [];

  Future<void> _orderNow() async {
    setState(() {
      _ordering = true;
    });

    await Provider.of<OrdersProvider>(context, listen: false).placeOrder({
      'totalAmount': cartAmount.toString(),
      'cartItems': cartCount.toString(),
      'date': DateTime.now().toIso8601String(),
    }, cartItems);

    await Provider.of<CartProvider>(context, listen: false).clearCart();

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
            StreamBuilder<List<CartItem>>(
                stream: Provider.of<CartProvider>(context).getCartItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cartItems = snapshot.data;
                    cartCount = 0;
                    cartAmount = 0;
                    cartItems.forEach((cartItem) {
                      cartCount += cartItem.quantity;
                      cartAmount += cartItem.quantity * cartItem.price;
                    });
                    return Chip(
                      label: Text(
                        '\$${cartAmount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    );
                  }
                  return CircularProgressIndicator();
                }),
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
