import 'package:flutter/material.dart';

import '../widgets/product_grid.dart';

class ProductOverViewScreen extends StatefulWidget {
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
              Navigator.of(context).pushNamed('/cart');
            },
          ),
        ],
      ),
      drawer: Drawer(),
      body: ProductGrid(_favouritesSelected),
    );
  }
}
