import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;

  CartItemWidget(this.title, this.imageUrl, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                Text('\$$price x $quantity'),
              ],
            ),
            Chip(
              label: FittedBox(
                child: Text(
                  '\$${(price * quantity).toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white),
                ),
                fit: BoxFit.fitWidth,
                alignment: Alignment.centerLeft,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
