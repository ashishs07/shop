import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';
import './providers/auth.dart';

import './screens/auth_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/product_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_mod_screen.dart';
import './screens/product_edit_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (_) => ProductsProvider(null, []),
          update: (_, auth, oldProducts) =>
              ProductsProvider(auth.token, oldProducts.items),
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, OrderProvider>(
          create: (_) => OrderProvider(null, []),
          update: (_, auth, oldOrders) =>
              OrderProvider(auth.token, oldOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.blue,
            fontFamily: 'Muli',
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          home: authData.isAuth ? ProductOverViewScreen() : AuthScreen(),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ProductOverViewScreen.routeName: (ctx) => ProductOverViewScreen(),
            ProductScreen.routeName: (ctx) => ProductScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserModScreen.routeName: (ctx) => UserModScreen(),
            ProductEditScreen.routeName: (ctx) => ProductEditScreen(),
          },
        ),
      ),
    );
  }
}
