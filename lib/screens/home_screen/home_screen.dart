import 'package:flutter/material.dart';

import '../cart_screen/cart_screen.dart';
import './products_list.dart';
import './home_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  static const pageName = 'HomePage';
  static const pageIcon = Icons.home;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      drawer: HomeDrawer(),
      body: ProductsList(),
    );
  }
}
