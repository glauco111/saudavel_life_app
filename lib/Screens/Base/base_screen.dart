import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/Screens/Home/home_screen.dart';
import 'package:saudavel_life_v2/Screens/Products/products_screen.dart';
import 'package:saudavel_life_v2/Screens/admin_orders/admin_orders_screen.dart';
import 'package:saudavel_life_v2/Screens/admin_users/admin_users_screen.dart';
import 'package:saudavel_life_v2/Screens/checkout_money/perfil_screen.dart';
import 'package:saudavel_life_v2/Screens/orders/order_screen.dart';
import 'package:saudavel_life_v2/models/page_manager.dart';
import 'package:saudavel_life_v2/models/user_manager.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              OrderScreen(),
              PerfilScreen(),
              if (userManager.adminEnabled) ...[
                AdminUsersScreen(),
                AdminOrdersScreen(),
              ],
            ],
          );
        },
      ),
    );
  }
}
