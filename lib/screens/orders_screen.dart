import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';

import '../screens/product_overview_screen.dart';
import '../widgets/drawer_global.dart';
import '../widgets/orders/order_expandable.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order';
  static const pageName = 'My Orders';
  static const pageIcon = Icons.credit_card;
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    final orderList = orderData.orders;
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductOverViewScreen.routeName);
            },
          ),
        ],
      ),
      drawer: DrawerGlobal(),
      body: ListView.builder(
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              child: ExpansionTile(
                  title: Text(orderList[index].id),
                  subtitle: Text('Amount \$ ${orderList[index].totalAmount}'),
                  children: orderData
                      .itemsInOrder(index)
                      .map((cartItem) => OrdersExpandable(
                          cartItem.id,
                          cartItem.title,
                          cartItem.imageUrl,
                          cartItem.price,
                          cartItem.quantity))
                      .toList())),
        ),
        itemCount: orderList.length,
      ),
    );
  }
}
