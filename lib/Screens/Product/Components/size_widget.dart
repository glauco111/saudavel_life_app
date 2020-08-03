import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/models/item_size.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/models/product.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({this.size});
  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;
    Color color;
    if (!size.hasStock) {
      color = Colors.red.withAlpha(70);
    } else if (selected) {
      color = Theme.of(context).primaryColor;
    } else {
      color = Colors.grey;
    }
    return GestureDetector(
      onTap: () {
        if (size.hasStock) {
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              color: color,
              child: Text(
                size.name,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                'R\$ ${size.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
