import 'package:flutter/material.dart';

import './screens/home_screen/home_screen.dart';
import './screens/cart_screen/cart_screen.dart';
import './screens/orders_screen/orders_screen.dart';
import './screens/product_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (ctx) => HomeScreen(),
  CartScreen.routeName: (ctx) => CartScreen(),
  OrdersScreen.routeName: (ctx) => OrdersScreen(),
  ProductScreen.routeName: (ctx) => ProductScreen(),
  /*  AuthScreen.routeName: (ctx) => AuthScreen(),
            ProductOverViewScreen.routeName: (ctx) => ProductOverViewScreen(),
            
            
            
            UserModScreen.routeName: (ctx) => UserModScreen(),
            ProductEditScreen.routeName: (ctx) => ProductEditScreen(), */
};
