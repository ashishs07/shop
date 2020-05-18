import 'package:flutter/material.dart';

import './screens/screens.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenDecider.routeName: (ctx) => ScreenDecider(),
  HomeScreen.routeName: (ctx) => HomeScreen(),
  CartScreen.routeName: (ctx) => CartScreen(),
  OrdersScreen.routeName: (ctx) => OrdersScreen(),
  ProductScreen.routeName: (ctx) => ProductScreen(),
  MyProductScreen.routeName: (ctx) => MyProductScreen(),
  EditProductScreen.routeName: (ctx) => EditProductScreen(),
};
