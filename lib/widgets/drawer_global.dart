import 'package:flutter/material.dart';

import '../screens/product_overview_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_mod_screen.dart';

class DrawerGlobal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          Container(
            child: Image.asset(
              'assets/images/kriov.jpeg',
              fit: BoxFit.cover,
            ),
            color: Colors.white,
          ),
          Divider(
            color: Colors.black54,
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
          Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: Icon(UserModScreen.pageIcon),
            title: Text(UserModScreen.pageName),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserModScreen.routeName),
          ),
        ],
      ),
    );
  }
}
