import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';
import 'package:saudavel_life_v2/models/checkout_manager.dart';

// ignore: must_be_immutable
class CheckoutMoneyScreen extends StatefulWidget {
  CheckoutMoneyScreen({this.value});
  bool value = true;
  @override
  _CheckoutMoneyScreenState createState() => _CheckoutMoneyScreenState();
}

class _CheckoutMoneyScreenState extends State<CheckoutMoneyScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        body: Consumer2<CheckoutManager, CartManager>(
          builder: (_, checkoutManager, cartManager, __) {
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
            return Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  Card(
                    elevation: 10,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () => setState(() => widget.value = false),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  cartManager.getProductInLoco();
                                  widget.value = false;
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                      color: (widget.value == false)
                                          ? Colors.green[300]
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Image.asset('assets/images/box.png'),
                                ),
                              ),
                              Text(
                                'Retirada',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 50),
                        GestureDetector(
                          onTap: () => setState(() => widget.value = true),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  cartManager.setDelivery();
                                  widget.value = true;
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                      color: (widget.value == true)
                                          ? Colors.green[300]
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5)),
                                  child:
                                      Image.asset('assets/images/delivery.png'),
                                ),
                              ),
                              Text(
                                'Delivery',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
