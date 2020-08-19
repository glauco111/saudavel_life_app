import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/models/order.dart';
import 'package:saudavel_life_v2/models/user.dart';

class OrdersManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Usuario usuario;

  List<Order> orders = [];

  StreamSubscription _subscription;

  void updateUser(Usuario usuario) {
    this.usuario = usuario;
    orders.clear();

    _subscription?.cancel();

    if (usuario != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firestore
        .collection('orders')
        .where('user', isEqualTo: usuario.id)
        .snapshots()
        .listen((event) {
      orders.clear();
      for (final doc in event.docs) {
        orders.add(Order.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
