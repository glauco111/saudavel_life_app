import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:saudavel_life_v2/Helpers/firebase_errors.dart';
import 'package:saudavel_life_v2/models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Usuario usuario;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // ignore: unused_field
  final bool _loadingFace = false;
  bool get loadingFace => _loading;
  set loadingFace(bool value) {
    _loading = value;
    notifyListeners();
  }

  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get isLoggedIn => usuario != null;

  Future<void> signIn(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: usuario.email, password: usuario.password);

      await _loadCurrentUser(firebaseUser: result.user);
      // ignore: avoid_print
      onSuccess();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: usuario.email, password: usuario.password);

      usuario.id = result.user.uid;
      this.usuario = usuario;
      await usuario.saveData();
      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> facebookLogin({Function onFail, Function onSuccess}) async {
    loadingFace = true;
    final result = await FacebookLogin().logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final credencial =
            FacebookAuthProvider.credential(result.accessToken.token);

        final authResult = await auth.signInWithCredential(credencial);

        if (authResult.user != null) {
          final firebaseUser = authResult.user;

          usuario = Usuario(
              id: firebaseUser.uid,
              name: firebaseUser.displayName,
              email: firebaseUser.email);

          await usuario.saveData();
          onSuccess();
        }

        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        onFail(result.errorMessage);
        break;
    }
    loadingFace = false;
  }

  void signOut() {
    auth.signOut();
    usuario = null;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? await auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      usuario = Usuario.fromDocument(docUser);

      final docAdmin =
          await firestore.collection('admins').doc(usuario.id).get();
      if (docAdmin.exists) {
        usuario.admin = true;
      }

      notifyListeners();
    }
  }

  bool get adminEnabled => usuario != null && usuario.admin;
}
