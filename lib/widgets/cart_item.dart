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
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            fit: BoxFit.scaleDown,
            height: 100,
            width: 100,
          ),
        ),
        title: Text(title),
        subtitle: Text('\$$price'),
        trailing: Text('$quantity x     \$${price * quantity}'),
      ),
    );
  }
}
