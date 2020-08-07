import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saudavel_life_v2/models/address.dart';
import 'package:saudavel_life_v2/models/cart_manager.dart';
import 'package:saudavel_life_v2/models/cart_product.dart';

class Order {
  final Firestore firestore = Firestore.instance;

  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
  }

  Future<void> save() async {
    firestore.collection('orders').document(orderId).setData(
      {
        'items': items.map((e) => e.toOrderItemMap()).toList(),
        'price': price,
        'user': userId,
        'address': address.toMap(),
      },
    );
  }

  String orderId;

  List<CartProduct> items;
  num price;

  String userId;

  Address address;

  Timestamp data;
}
