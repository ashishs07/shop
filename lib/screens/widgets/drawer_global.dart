import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../screen_decider.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/cart_screen/cart_screen.dart';
import '../../screens/orders_screen/orders_screen.dart';

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
          Divider(color: Colors.black54),
          ListTile(
            leading: Icon(HomeScreen.pageIcon),
            title: Text(HomeScreen.pageName),
            onTap: () =>
                Navigator.of(context).pushNamed(ScreenDecider.routeName),
          ),
          ListTile(
            leading: Icon(CartScreen.pageIcon),
            title: Text(CartScreen.pageName),
            onTap: () => Navigator.of(context).pushNamed(CartScreen.routeName),
          ),
          ListTile(
            leading: Icon(OrdersScreen.pageIcon),
            title: Text(OrdersScreen.pageName),
            onTap: () =>
                Navigator.of(context).pushNamed(OrdersScreen.routeName),
          ),
          Divider(color: Colors.black54),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              Navigator.of(context).pop();
              await Provider.of<AuthProvider>(context, listen: false).signOut();
              //Navigator.of(context)
              //    .pushReplacementNamed(ScreenDecider.routeName);
            },
          ),
        ],
      ),
    );
  }
}
