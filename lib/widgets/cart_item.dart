import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;

  CartItemWidget(
      this.productId, this.title, this.imageUrl, this.price, this.quantity);

  Widget _buildImageRRect() {
    // Image ClipRRect
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        imageUrl,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitlePQColumn(BuildContext context) {
    // Title Price and Quantity Column
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text('\$$price x $quantity'),
      ],
    );
  }

  Widget _buildTotalPriceChip(BuildContext context) {
    // Total Price Chip
    return Chip(
      label: FittedBox(
        child: Text(
          '\$${(price * quantity).toStringAsFixed(2)}',
          style: TextStyle(color: Colors.white),
        ),
        fit: BoxFit.fitWidth,
        alignment: Alignment.centerLeft,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildMainCard(BuildContext context) {
    // Main Card
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildImageRRect(),
            _buildTitlePQColumn(context),
            _buildTotalPriceChip(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDismissBackG() {
    // Dissmissible Background (GREEN - Like)
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
          Icons.thumb_up,
          size: 40,
        ),
      ),
      color: Colors.green,
    );
  }

  Widget _buildDismiss2ndBackG() {
    // Dissmissible Secondary Background (RED - Delete)
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
          Icons.delete,
          size: 40,
        ),
      ),
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: _buildMainCard(context),
      background: _buildDismissBackG(),
      secondaryBackground: _buildDismiss2ndBackG(),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          Provider.of<CartProvider>(context, listen: false)
              .removeItem(productId);
        }
      },
    );
  }
}
