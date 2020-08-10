import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/common/card/price_card.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';

import 'components/address_card.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AddressCard(),
          Consumer<CartManager>(
            builder: (_, cartManager, __) {
              return PriceCard(
                buttonText: 'Continuar para o pagamento',
                onPressed: cartManager.isAddressValid
                    ? () {
                        Navigator.of(context).pushNamed('/checkout');
                      }
                    : null,
              );
            },
          )
        ],
      ),
    );
  }
}
