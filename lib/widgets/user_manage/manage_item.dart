import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';

import '../../screens/product_screen.dart';

class ManageItem extends StatelessWidget {
  final int index;

  ManageItem(this.index);
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
                  onPressed: () {},
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
                            onPressed: () {
                              productData.removeProduct(index);
                              Navigator.of(context).pop();
                              Scaffold.of(context).hideCurrentSnackBar();
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Item Successfully Removed!!'),
                                  duration: Duration(seconds: 2),
                                  //behavior: SnackBarBehavior.floating,
                                ),
                              );
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
