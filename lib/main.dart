import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';

import './screens/product_overview_screen.dart';
import './screens/product_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_mod_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OrderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.blue,
            fontFamily: 'Muli',
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            )),
        routes: {
          ProductOverViewScreen.routeName: (ctx) => ProductOverViewScreen(),
          ProductScreen.routeName: (ctx) => ProductScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserModScreen.routeName: (ctx) => UserModScreen(),
        },
      ),
    );
  }
}
