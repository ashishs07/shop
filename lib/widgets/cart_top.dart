import 'package:flutter/material.dart';

class CartTopCard extends StatelessWidget {
  final int totalQuantity;
  final double totalAmount;

  CartTopCard(this.totalQuantity, this.totalAmount);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
            /* Chip(
              label: Text(
                totalQuantity.toString(),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ), */
            SizedBox(
              width: 15,
            ),
            Chip(
              label: Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'ORDER NOW',
              style: TextStyle(color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
