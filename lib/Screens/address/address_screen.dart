import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/Screens/checkout_money/components/delivery_card.dart';
import 'package:saudavel_life_v2/common/card/price_card.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';

import 'components/address_card.dart';

// ignore: must_be_immutable
class AddressScreen extends StatefulWidget {
  bool value1 = true;

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Color verde = Colors.green[300];
  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          DeliveryCard(),
          if (cartManager.deliveryPrice != 0) AddressCard(),
          TextPayment(),
          Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () => setState(() => widget.value1 = false),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                            color: (widget.value1 == false)
                                ? verde
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5)),
                        child: Image.asset('assets/images/dinheiro.png'),
                      ),
                      const Text(
                        'Dinheiro',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                GestureDetector(
                  onTap: () => setState(() => widget.value1 = true),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                            color: (widget.value1 == true)
                                ? verde
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5)),
                        child: Image.asset('assets/images/pagar.png'),
                      ),
                      const Text(
                        'Cartão',
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
          Consumer<CartManager>(
            builder: (_, cartManager, __) {
              return Column(
                children: <Widget>[
                  PriceCard(
                    buttonText: 'Finalizar Compra',
                    onPressed: cartManager.isAddressValid
                        ? () {
                            // ignore: unrelated_type_equality_checks
                            widget.value1 == true
                                ? Navigator.of(context).pushNamed('/checkout')
                                : Navigator.of(context).pushNamed('/checkout');
                          }
                        : null,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class TextPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Selecione a forma de Pagamento',
        style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 41, 84, 38),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
