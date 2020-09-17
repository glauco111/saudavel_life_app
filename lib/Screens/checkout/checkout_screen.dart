import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/common/card/price_card.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';
import 'package:saudavel_life_v2/models/checkout_manager.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Processando seu pagamento...',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    )
                  ],
                ),
              );
            }
            return Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  //CreditCardWidget(),
                  PriceCard(
                    buttonText: 'Finalizar Pedido',
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        checkoutManager.checkout(onStockFail: (e) {
                          Navigator.of(context).popUntil(
                              (route) => route.settings.name == '/cart');
                        }, onSuccess: (order) {
                          Navigator.of(context)
                              .popUntil((route) => route.settings.name == '/');
                          Navigator.of(context)
                              .pushNamed('/confirmation', arguments: order);
                        });
                      }
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
