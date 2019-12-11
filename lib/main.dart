import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products_provider.dart';
import './providers/cart_provider.dart';

import './screens/product_overview_screen.dart';
import './screens/product_screen.dart';
import './screens/cart_screen.dart';

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.indigoAccent,
          fontFamily: 'Muli',
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductScreen.routeName: (ctx) => ProductScreen(),
          '/cart': (ctx) => CartScreen(),
        },
      ),
    );
  }
}
