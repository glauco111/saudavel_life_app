import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saudavel_life_v2/models/address.dart';

class User {
  User({this.email, this.password, this.name, this.password2, this.id});

  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    if (document.data.containsKey('address')) {
      address =
          Address.fromMap(document.data['address'] as Map<String, dynamic>);
    }
  }

  String id;
  String email;
  String password;
  String name;
  String password2;
  bool admin = false;
  Address address;
  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get carReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if (address != null) 'address': address.toMap()
    };
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }
}
