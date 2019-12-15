import 'package:flutter/material.dart';

import '../screens/product_overview_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';

class DrawerGlobal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Image.asset('assets/images/kriov.jpeg'),
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(ProductOverViewScreen.pageIcon),
            title: Text(ProductOverViewScreen.pageName),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductOverViewScreen.routeName),
          ),
          ListTile(
            leading: Icon(CartScreen.pageIcon),
            title: Text(CartScreen.pageName),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(CartScreen.routeName),
          ),
          ListTile(
            leading: Icon(OrdersScreen.pageIcon),
            title: Text(OrdersScreen.pageName),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
          ),
        ],
      ),
    );
  }
}
