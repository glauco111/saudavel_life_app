import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:saudavel_life_v2/models/order.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog(this.order);
  final ScreenshotController screenshotController = ScreenshotController();
  final Order order;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Endereço de Entrega'),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          child: Text(
            '${order.address.street}, ${order.address.number} ${order.address.complement}\n'
            '${order.address.district}\n'
            '${order.address.city}/${order.address.state}\n'
            '${order.address.zipCode}',
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            Navigator.of(context).pop();
            final file = await screenshotController.capture();
            await GallerySaver.saveImage(file.path);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Exportar'),
        )
      ],
    );
  }
}
