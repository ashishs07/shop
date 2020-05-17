import 'package:flutter/material.dart';

import './screens/screen_decider.dart';
import './screens/home_screen/home_screen.dart';
import './screens/cart_screen/cart_screen.dart';
import './screens/orders_screen/orders_screen.dart';
import './screens/product_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenDecider.routeName: (ctx) => ScreenDecider(),
  HomeScreen.routeName: (ctx) => HomeScreen(),
  CartScreen.routeName: (ctx) => CartScreen(),
  OrdersScreen.routeName: (ctx) => OrdersScreen(),
  ProductScreen.routeName: (ctx) => ProductScreen(),
};
