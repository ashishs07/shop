import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart_item.dart';

import '../../providers/orders_provider.dart';
import '../../models/order_item.dart';
import './order_expandable.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order';
  static const pageName = 'My Orders';
  static const pageIcon = Icons.credit_card;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageName)),
      body: _buildOrdersStream(context),
    );
  }

  Widget _buildOrdersStream(BuildContext context) {
    return StreamBuilder<List<OrderItem>>(
        stream: Provider.of<OrdersProvider>(context).getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              final orders = snapshot.data.reversed.toList();
              return _buildOrderDataStream(context, orders);
            } else {
              return Center(child: Text('No Orders'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildOrderDataStream(BuildContext context, List<OrderItem> orders) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<CartItem>>(
            stream: Provider.of<OrdersProvider>(context)
                .getOrderItems(orders[index].id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final items = snapshot.data;
                final children = items
                    .map((cartItem) => OrdersExpandable(
                        cartItem.id,
                        cartItem.title,
                        cartItem.imageUrl,
                        cartItem.price,
                        cartItem.quantity))
                    .toList();
                return Card(
                    child: ExpansionTile(
                  backgroundColor: Colors.black26,
                  title: Text(orders[index].date.toString()),
                  subtitle: Text('Amount \$ ${orders[index].totalAmount}'),
                  children: children,
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
      itemCount: orders.length,
    );
  }
}
