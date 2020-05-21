import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../../models/product.dart';
import './editProduct_screen.dart';
import './myProduct_item.dart';

class MyProductScreen extends StatelessWidget {
  static const routeName = '/myProducts';
  static const pageName = 'Manage';
  static const pageIcon = Icons.edit;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(pageName)),
      body: StreamBuilder<List<Product>>(
          stream: Provider.of<ProductsProvider>(context).getUserProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                  itemBuilder: (ctx, index) =>
                      MyProductItem(snapshot.data[index]),
                  itemCount: snapshot.data.length,
                );
              } else {
                return Center(child: Text('No Products Added.'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          var mod = await Navigator.of(context)
              .pushNamed(EditProductScreen.routeName);
          if (mod == null) return;
          _scaffoldKey.currentState
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(mod),
            ));
        },
      ),
    );
  }
}
