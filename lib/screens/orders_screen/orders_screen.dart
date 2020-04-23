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
      body: StreamBuilder<List<OrderItem>>(
          stream: Provider.of<OrdersProvider>(context).getOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final orders = snapshot.data.reversed.toList();
              return ListView.builder(
                itemBuilder: (ctx, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<List<CartItem>>(
                      stream: Provider.of<OrdersProvider>(context)
                          .getOrderItems(orders[index].id),
                      builder: (context, snapshot2) {
                        if (snapshot2.hasData) {
                          final items = snapshot2.data;
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
                            title: Text(orders[index].id),
                            subtitle:
                                Text('Amount \$ ${orders[index].totalAmount}'),
                            children: children,
                          ));
                        }
                        return CircularProgressIndicator();
                      }),
                ),
                itemCount: orders.length,
              );
            } else {
              return Center(child: Text('No Orders'));
            }
          }),
    );
  }
}
