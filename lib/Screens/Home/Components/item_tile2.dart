import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/models/home_manager.dart';
import 'package:saudavel_life_v2/models/product.dart';
// ignore: directives_ordering
import 'dart:io';
import 'package:saudavel_life_v2/models/product_manager.dart';
import 'package:saudavel_life_v2/models/section.dart';
import 'package:saudavel_life_v2/models/section_item.dart';
import 'package:provider/provider.dart';

class ItemTile2 extends StatelessWidget {
  const ItemTile2(this.item);
  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
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
      onLongPress: homeManager.editing
          ? () {
              showDialog(
                  context: context,
                  builder: (_) {
                    final product = context
                        .read<ProductManager>()
                        .findProductById(item.product);
                    return AlertDialog(
                      title: const Text("Editar Item"),
                      content: product != null
                          ? ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Image.network(product.images.first),
                              title: Text(product.name),
                              subtitle: Text(
                                  "R\$ ${product.basePrice.toStringAsFixed(2)}"),
                            )
                          : null,
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            context.read<Section>().removeItem(item);
                            Navigator.of(context).pop();
                          },
                          // ignore: sort_child_properties_last
                          child: const Text("Excluir"),
                          textColor: Colors.red,
                        ),
                        FlatButton(
                          onPressed: () async {
                            if (product != null) {
                              item.product = null;
                            } else {
                              final Product product =
                                  await Navigator.of(context)
                                      .pushNamed('/select_product') as Product;
                              item.product = product?.id;
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(
                              product != null ? "Desvincular" : "Vincular"),
                        ),
                      ],
                    );
                  });
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 5.0,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(150),
            color: Colors.black),
        child: item.image is String
            ? CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(item.image as String),
                foregroundColor: Colors.red,
              )
            : Image.file(
                item.image as File,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
