import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth_provider.dart';
import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';
import './routes.dart';
import './screens/screen_decider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ProxyProvider<AuthProvider, ProductsProvider>(
          update: (_, auth, cart) => ProductsProvider(auth.user.uid),
        ),
        ProxyProvider<AuthProvider, CartProvider>(
          update: (_, auth, cart) => CartProvider(auth.user.uid),
        ),
        ProxyProvider<AuthProvider, OrdersProvider>(
          update: (_, auth, cart) => OrdersProvider(auth.user.uid),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.blue,
          fontFamily: 'Muli',
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        home: ScreenDecider(),
        routes: routes,
      ),
    );
  }
}
