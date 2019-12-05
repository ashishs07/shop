import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products_provider.dart';

import './screens/product_overview_screen.dart';
import './screens/product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ProductsProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'WorkSans',
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductScreen.routeName: (ctx) => ProductScreen(),
        },
      ),
    );
  }
}
