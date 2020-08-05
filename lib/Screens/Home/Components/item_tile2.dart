import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/models/product_manager.dart';
import 'package:saudavel_life_v2/models/section_item.dart';
import 'package:provider/provider.dart';

class ItemTile2 extends StatelessWidget {
  const ItemTile2(this.item);
  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductManager>().findProductById(item.product);
          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(2),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            // Circle shape
            shape: BoxShape.circle,
            color: Colors.black,
            // The border you want
            border: Border.all(
              width: 2.0,
              color: Colors.white,
            ),
            // The shadow you want
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(item.image as String),
            foregroundColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
