import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/common/price_card.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';
import 'package:saudavel_life_v2/models/checkout_manager.dart';
import 'package:saudavel_life_v2/models/page_manager.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __) {
            if (checkoutManager.loading) {
              return Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Processando seu pagamento...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }
            return ListView(
              children: <Widget>[
                PriceCard(
                  buttonText: 'Finalizar Pedido',
                  onPressed: () {
                    checkoutManager.checkout(onStockFail: (e) {
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: const Text(
                              'Ocorreu uma falha ao processar sua compra'),
                        ),
                      );
                      Navigator.of(context)
                          .popUntil((route) => route.settings.name == '/cart');
                    }, onSuccess: (order) {
                      Navigator.of(context)
                          .popUntil((route) => route.settings.name == '/base');
                      Navigator.of(context)
                          .pushNamed('/confirmation', arguments: order);
                    });
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
