import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../product_screen/product_screen.dart';
import './editProduct_screen.dart';
import '../../models/product.dart';

class MyProductItem extends StatelessWidget {
  final Product product;
  MyProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(product.title),
          leading:
              CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                _buildEditButton(context),
                _buildDeleteButton(context),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductScreen.routeName, arguments: product);
          },
        ),
        Divider(),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      color: Theme.of(context).primaryColor,
      onPressed: () async {
        var mod = await Navigator.of(context)
            .pushNamed(EditProductScreen.routeName, arguments: product);
        if (mod == null) return;
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(mod)));
      },
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      color: Theme.of(context).errorColor,
      onPressed: () {
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This will remove the product'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () async {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(product.id);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
