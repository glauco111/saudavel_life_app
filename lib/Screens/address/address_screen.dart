import 'package:flutter/material.dart';

import 'components/address_card.dart';

class AddressScrenn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Endereço de Entrega"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AddressCard(),
        ],
      ),
    );
  }
}
