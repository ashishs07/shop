import 'package:flutter/material.dart';

import './cart_screen.dart';

import '../widgets/product_grid.dart';
import '../widgets/drawer_global.dart';

class ProductOverViewScreen extends StatefulWidget {
  static const routeName = '/';
  static const pageName = 'HomePage';
  static const pageIcon = Icons.home;
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _favouritesSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                _favouritesSelected ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                _favouritesSelected = !_favouritesSelected;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      drawer: DrawerGlobal(),
      drawerEdgeDragWidth: 100,
      body: ProductGrid(_favouritesSelected),
    );
  }
}
