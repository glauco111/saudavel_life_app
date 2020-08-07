import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
    print(cartManager.totalPrice);
  }

  void checkout() {
    _decrementStock();
  }

  void _decrementStock() {}
}
