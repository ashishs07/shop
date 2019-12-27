import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';

import '../../screens/product_screen.dart';
import '../../screens/product_edit_screen.dart';

class ManageItem extends StatelessWidget {
  final int index;

  ManageItem(this.index);

  Future<void> _deleteProduct(BuildContext context,
      ProductsProvider productData, List<dynamic> productList) async {
    Navigator.of(context).pop();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Removing Item..'),
        duration: Duration(seconds: 6),
      ),
    );
    await productData.deleteProduct(productList[index].id);
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Item Successfully Removed!!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final productList = productData.items;
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(productList[index].title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(productList[index].imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pushNamed(ProductEditScreen.routeName,
                        arguments: productList[index].id);
                  },
                ),
                IconButton(
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
                            onPressed: () => _deleteProduct(
                                context, productData, productList),
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
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ProductScreen.routeName,
                arguments: productList[index].id);
          },
        ),
        Divider(),
      ],
    );
  }
}
