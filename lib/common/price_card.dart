import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({this.buttonText, this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Resumo do pedido',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Subtotal:'),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}')
              ],
            ),
            const Divider(),
            if (deliveryPrice != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Entrega:'),
                  Text('R\$ ${deliveryPrice.toStringAsFixed(2)}')
                ],
              ),
              const Divider(),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('total',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                Text('R\$ ${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Theme.of(context).primaryColor))
              ],
            ),
            const SizedBox(height: 8),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
              onPressed: onPressed,
              child: const Text('Finalizar Pedido'),
            )
          ],
        ),
      ),
    );
  }
}
