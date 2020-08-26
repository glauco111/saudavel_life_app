import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saudavel_life_v2/common/widgets/custom_icon_buttom.dart';
import 'package:saudavel_life_v2/models/address.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/models/user.dart';

class CepSignup extends StatefulWidget {
  const CepSignup(this.address);

  final Address address;

  @override
  _CepSignup createState() => _CepSignup();
}

class _CepSignup extends State<CepSignup> {
  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    if (widget.address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: cepController,
            decoration: const InputDecoration(
                isDense: true, labelText: 'CEP', hintText: '12.345-678'),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            validator: (cep) {
              if (cep.isEmpty) {
                return 'Campo obrigatório';
              } else if (cep.length != 10) return 'CEP Inválido';
              return null;
            },
          ),
          RaisedButton(
            onPressed: () async {
              if (Form.of(context).validate()) {
                try {
                  await context.read<User>().getAddress(cepController.text);
                } catch (e) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('$e'),
                    ),
                  );
                }
              }
            },
            textColor: Colors.white,
            color: primaryColor,
            disabledColor: primaryColor.withAlpha(100),
            child: const Text('Buscar CEP'),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'CEP: ${widget.address.zipCode}',
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
              ),
            ),
            CustomIconButtom(
              iconData: Icons.edit,
              color: primaryColor,
              size: 20,
              onTap: () {
                context.read<User>().removeAddress();
              },
            ),
          ],
        ),
      );
    }
  }
}
