import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';

// ignore: must_be_immutable
class DeliveryCard extends StatefulWidget {
  bool value;
  @override
  _DeliveryCardState createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(width: 30),
          GestureDetector(
            onTap: () {
              widget.value = false;
              cartManager.getProductInLoco();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      color: (cartManager.deliveryPrice == 0)
                          ? Colors.green[300]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Image.asset('assets/images/box.png'),
                ),
                const Text(
                  'Retirada',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
          const SizedBox(width: 50),
          GestureDetector(
            onTap: () {
              widget.value = true;
              cartManager.setDelivery();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      color: (cartManager.deliveryPrice != 0)
                          ? Colors.green[300]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Image.asset('assets/images/delivery.png'),
                ),
                const Text(
                  'Delivery',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }
}
