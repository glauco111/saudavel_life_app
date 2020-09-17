import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/models/product.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  final Product product;
  const ImagesForm(this.product);
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      validator: (images) {
        if (images.isEmpty) {
          return 'Adicione ao menos 1 imagem';
        }
        return null;
      },
      onSaved: (images) => product.newImages = images,
      builder: (state) {
        void onImageSelected(File file) {
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: state.value.map<Widget>(
                  (image) {
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        if (image is String)
                          Image.network(
                            image,
                            fit: BoxFit.cover,
                          )
                        else
                          Image.file(
                            image as File,
                            fit: BoxFit.cover,
                          ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              icon: const Icon(Icons.remove, color: Colors.red),
                              onPressed: () {
                                state.value.remove(image);
                                state.didChange(state.value);
                              }),
                        ),
                      ],
                    );
                  },
                ).toList()
                  ..add(Material(
                    color: Colors.grey[100],
                    child: IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        iconSize: 50,
                        color: primaryColor,
                        onPressed: () {
                          if (Platform.isAndroid) {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) => ImageSourceSheet(
                                      onImageSelected: onImageSelected,
                                    ));
                          } else {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (_) => ImageSourceSheet(
                                      onImageSelected: onImageSelected,
                                    ));
                          }
                        }),
                  )),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            if (state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  state.errorText,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
          ],
        );
      },
    );
  }
}
