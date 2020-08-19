import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/common/order/order_tile.dart';
import 'package:saudavel_life_v2/common/custom_drawer/custom_drawer.dart';
import 'package:saudavel_life_v2/common/card/empty_card.dart';
import 'package:saudavel_life_v2/common/card/login_card.dart';
import 'package:saudavel_life_v2/models/orders_manager.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.usuario == null) {
            return LoginCard();
          }
          if (ordersManager.orders.isEmpty) {
            return EmptyCard(
              title: 'Nenhuma compra encontrada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: ordersManager.orders.length,
              itemBuilder: (_, index) {
                return OrderTile(ordersManager.orders.reversed.toList()[index]);
              });
        },
      ),
    );
  }
}
