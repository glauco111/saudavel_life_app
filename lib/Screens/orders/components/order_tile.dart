import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/Screens/orders/components/OrderProductTile.dart';
import 'package:saudavel_life_v2/models/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  const OrderTile(this.order);
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.formattedId,
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.w600),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14),
                )
              ],
            ),
            Text(
              'Em Transporte',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  fontSize: 14),
            )
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map(
              (e) {
                return OrderProductTile(e);
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
