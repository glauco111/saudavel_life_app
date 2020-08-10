import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/common/order/OrderProductTile.dart';
import 'package:saudavel_life_v2/models/order.dart';

import 'cancel_order_dialog.dart';
import 'export_address_dialog.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.order, {this.showControls = false});

  final Order order;
  final bool showControls;

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
              order.statusText,
              style: TextStyle(
                  fontWeight: order.status == Status.canceled
                      ? FontWeight.bold
                      : FontWeight.w400,
                  color: order.status == Status.canceled
                      ? Colors.red
                      : primaryColor,
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
          ),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  FlatButton(
                      textColor: Colors.red,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => CancelOrderDialog(order));
                      },
                      child: const Text('Cancelar')),
                  FlatButton(
                      onPressed: order.back, child: const Text('Recuar')),
                  FlatButton(
                      onPressed: order.advance, child: const Text('Avançar')),
                  FlatButton(
                      textColor: primaryColor,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => ExportAddressDialog(order));
                      },
                      child: const Text('Endereço')),
                ],
              ),
            )
        ],
      ),
    );
  }
}
