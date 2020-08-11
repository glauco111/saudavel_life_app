import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saudavel_life_v2/Screens/checkout/components/card_text_field.dart';

class CardBack extends StatelessWidget {
  const CardBack({this.cvvFocus});
  final FocusNode cvvFocus;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 16,
      child: Container(
        color: const Color(0xFF3a6f37),
        height: 200,
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              color: Colors.black,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 70,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    margin: const EdgeInsets.only(left: 12),
                    color: Colors.grey,
                    child: CardTextField(
                      textInputType: TextInputType.number,
                      textAlign: TextAlign.end,
                      maxLength: 3,
                      hint: '123',
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      validator: (cvv) {
                        // ignore: unrelated_type_equality_checks
                        if (cvv != 3) {
                          return 'inválido';
                        }
                        return null;
                      },
                      focusNode: cvvFocus,
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
