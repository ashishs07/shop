import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

import './cart_screen.dart';

import '../widgets/homepage/product_grid.dart';
import '../widgets/drawer_global.dart';

class ProductOverViewScreen extends StatefulWidget {
  static const routeName = '/home';
  static const pageName = 'HomePage';
  static const pageIcon = Icons.home;
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _favouritesSelected = false;
  var _initState = true;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_initState) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _initState = false;
    super.didChangeDependencies();
  }

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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(_favouritesSelected),
    );
  }
}
