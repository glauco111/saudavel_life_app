import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/Screens/checkout/components/card_back.dart';
import 'package:saudavel_life_v2/Screens/checkout/components/card_front.dart';

class CreditCardWidget extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FlipCard(
            key: cardKey,
            flipOnTouch: false,
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            front: CardFront(
                numberFocus: numberFocus,
                dateFocus: dateFocus,
                nameFocus: nameFocus,
                finished: () {
                  cardKey.currentState.toggleCard();
                  cvvFocus.requestFocus();
                }),
            back: CardBack(cvvFocus: cvvFocus),
          ),
          FlatButton(
              textColor: Colors.white,
              padding: EdgeInsets.zero,
              onPressed: () {
                cardKey.currentState.toggleCard();
              },
              child: const Text('Virar Cartão'))
        ],
      ),
    );
  }
}
