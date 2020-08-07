import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/Screens/Base/base_screen.dart';
import 'package:saudavel_life_v2/Screens/Edit_Product/edit_product_screen.dart';
import 'package:saudavel_life_v2/Screens/SignUp/signup_screen.dart';
import 'package:saudavel_life_v2/models/admin_users_manager.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';
import 'package:saudavel_life_v2/models/home_manager.dart';
import 'package:saudavel_life_v2/models/product_manager.dart';
import 'package:saudavel_life_v2/models/user_manager.dart';

import 'Screens/Cart/cart_screen.dart';
import 'Screens/address/address_screen.dart';
// ignore: directives_ordering
import 'Screens/Login/login_screen.dart';
import 'Screens/Product/product_screen.dart';
import 'Screens/checkout/checkout_screen.dart';
import 'Screens/select_product/select_product_screen.dart';
import 'models/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager..updateUser(userManager),
        )
      ],
      child: MaterialApp(
        title: 'Saudavel Life App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(255, 41, 84, 38),
          scaffoldBackgroundColor: const Color.fromARGB(255, 41, 84, 38),
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(settings.arguments as Product));
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) =>
                      EditProductScreen(settings.arguments as Product));
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());
            case '/address':
              return MaterialPageRoute(builder: (_) => AddressScreen());
            case '/checkout':
              return MaterialPageRoute(builder: (_) => CheckoutScreen());
            case '/signUp':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/select_product':
              return MaterialPageRoute(builder: (_) => SelectProductScreen());
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
