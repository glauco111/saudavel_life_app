import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:saudavel_life_v2/models/cart_product.dart';
import 'package:saudavel_life_v2/models/product.dart';
import 'package:saudavel_life_v2/models/user.dart';
import 'package:saudavel_life_v2/models/user_manager.dart';
import 'package:saudavel_life_v2/services/cep_aberto_service.dart';

import 'address.dart';

class CartManager extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<CartProduct> items = [];

  Usuario user;
  Address address;

  num productsPrice = 0.0;
  num deliveryPrice;
  num deliveryz;
  num get totalPrice => productsPrice + (deliveryPrice ?? 0);
  num get totalPrice2 => productsPrice;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateUser(UserManager userManager) {
    user = userManager.usuario;
    productsPrice = 0.0;
    items.clear();
    removeAddress();

    if (user != null) {
      _loadCartItems();
      _loadUserAddress();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.carReference.get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  Future<void> _loadUserAddress() async {
    if (user.address != null &&
        await calculateDelivery(user.address.lat, user.address.long)) {
      address = user.address;
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.carReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.carReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null) {
      user.carReference.doc(cartProduct.id).update(cartProduct.toCartItemMap());
    }
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }

  bool get isAddressValid => address != null && deliveryPrice != null;

  //address
  Future<void> getAddress(String cep) async {
    loading = true;
    final cepAbertoService = CepAbertoService();
    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      if (cepAbertoAddress != null) {
        address = Address(
            street: cepAbertoAddress.logradouro,
            district: cepAbertoAddress.bairro,
            zipCode: cepAbertoAddress.cep,
            city: cepAbertoAddress.cidade.nome,
            state: cepAbertoAddress.estado.sigla,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude);
      }
      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('Cep Inválido');
    }
  }

  Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;
    if (await calculateDelivery(address.lat, address.long)) {
      user.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error("Endereço fora do raio de entrega :/");
    }
  }

  void getProductInLoco() {
    deliveryPrice = 0;
    notifyListeners();
  }

  void setDelivery() {
    deliveryPrice = deliveryz;
    notifyListeners();
  }

  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  // ignore: missing_return
  Future<bool> calculateDelivery(double lat, double long) async {
    final DocumentSnapshot d = await firestore.doc('aux/delivery').get();
    final latStore = d.data()['lat'] as double;
    final longStore = d.data()['long'] as double;

    double dis =
        await Geolocator().distanceBetween(latStore, longStore, lat, long);

    final maxKm = d.data()['maxKm'] as num;
    final base = d.data()['base'] as num;
    final km = d.data()['km'] as num;

    dis /= 1000.0;

    if (dis > maxKm) {
      return false;
    }

    deliveryPrice = base + dis * km;
    deliveryz = base + dis * km;
    return true;
  }

  void clear() {
    for (final cartProduct in items) {
      user.carReference.doc(cartProduct.id).delete();
    }
    items.clear();
    notifyListeners();
  }
}
