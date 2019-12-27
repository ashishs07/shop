import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

import '../screens/product_edit_screen.dart';

import '../widgets/drawer_global.dart';
import '../widgets/user_manage/manage_item.dart';

class UserModScreen extends StatelessWidget {
  static const routeName = '/user';
  static const pageName = 'Manage';
  static const pageIcon = Icons.edit;

  Future<void> _onRefreshProdcuts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ProductEditScreen.routeName);
            },
          )
        ],
      ),
      drawer: DrawerGlobal(),
      body: RefreshIndicator(
        onRefresh: () => _onRefreshProdcuts(context),
        child: ListView.builder(
          itemBuilder: (ctx, index) => ManageItem(index),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}