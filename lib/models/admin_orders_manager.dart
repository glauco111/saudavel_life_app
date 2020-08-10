import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/models/user.dart';

import 'order.dart';

class AdminOrdersManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;

  User userFilter;
  List<Status> statusFilter = [Status.preparing];

  final List<Order> _orders = [];

  StreamSubscription _subscription;

  void updateAdmin({bool adminEnabled}) {
    _orders.clear();

    _subscription?.cancel();

    if (adminEnabled) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firestore.collection('orders').snapshots().listen((event) {
      for (final change in event.documentChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(Order.fromDocument(change.document));
            break;
          case DocumentChangeType.modified:
            final modOrder = _orders
                .firstWhere((o) => o.orderId == change.document.documentID);
            modOrder.updateFromDocument(change.document);
            break;
          case DocumentChangeType.removed:
            debugPrint('erro inesperado no adminOrdersManager no removed');
            break;
        }
      }
      notifyListeners();
    });
  }

  void setUserFilter(User user) {
    userFilter = user;
    notifyListeners();
  }

  List<Order> get filteredOrders {
    List<Order> output = _orders.reversed.toList();

    if (userFilter != null) {
      output = output.where((o) => o.userId == userFilter.id).toList();
    }

    return output.where((o) => statusFilter.contains(o.status)).toList();
  }

  void setStatusFilter({Status status, bool enabled}) {
    if (enabled) {
      statusFilter.add(status);
    } else {
      statusFilter.remove(status);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
