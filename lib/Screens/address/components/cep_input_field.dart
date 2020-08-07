import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saudavel_life_v2/models/address.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {
  final TextEditingController cepController = TextEditingController();

  CepInputField(Address address);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          controller: cepController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          decoration: const InputDecoration(
              isDense: true, labelText: "Cep", hintText: "12345-000"),
          validator: (cep) {
            if (cep.isEmpty) {
              return 'Campo obrigatório';
            } else if (cep.length != 10) {
              return 'CEP Inválido';
            }
            return null;
          },
        ),
        RaisedButton(
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          disabledColor: Theme.of(context).primaryColor.withAlpha(100),
          onPressed: () {
            // ignore: avoid_print
            if (Form.of(context).validate()) {
              context.read<CartManager>().getAddress(cepController.text);
            }
          },
          child: const Text("Buscar Cep"),
        )
      ],
    );
  }
}
