import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:saudavel_life_v2/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<Product> allProducts = [];

  String _search = '';
  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filterProducts {
    final List<Product> filterProducts = [];
    if (search.isEmpty) {
      filterProducts.addAll(allProducts);
    } else {
      filterProducts.addAll(
        allProducts.where(
          (p) => p.name.toLowerCase().contains(
                search.toLowerCase(),
              ),
        ),
      );
    }
    return filterProducts;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore
        .collection('products')
        .where('deleted', isEqualTo: false || null)
        .getDocuments();

    allProducts =
        snapProducts.documents.map((d) => Product.fromDocument(d)).toList();
    notifyListeners();
  }

  Product findProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  void delete(Product product) {
    product.delete();
    allProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }
}
