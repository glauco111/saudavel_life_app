import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/Screens/checkout_money/components/address_card2.dart';
import 'package:saudavel_life_v2/common/card/login_card.dart';
import 'package:saudavel_life_v2/common/custom_drawer/custom_drawer.dart';
import 'package:saudavel_life_v2/models/user_manager.dart';

// ignore: must_be_immutable
class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String fotoz =
        'https://firebasestorage.googleapis.com/v0/b/saudavel-life-v2.appspot.com/o/saudavellife.png?alt=media&token=ed4232a4-4ade-49ce-82c6-5f89bcc37187';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu Perfil',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: Consumer<UserManager>(builder: (_, userManager, __) {
        if (userManager.user == null) {
          return LoginCard();
        }
        return ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color.fromARGB(255, 28, 57, 24), Colors.green],
                      ),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(90))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Spacer(),
                      Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: CircleAvatar(
                          radius: 73,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                              foregroundColor: Colors.white,
                              radius: 70,
                              backgroundColor: Colors.green[800],
                              backgroundImage: NetworkImage(
                                // ignore: unnecessary_string_interpolations
                                '${userManager.user?.foto ?? fotoz}',
                              )),
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        color: Colors.white,
                        onPressed: () {},
                        child: Text("Alterar Foto",
                            style: TextStyle(color: Colors.green[900])),
                      ),
                      //Spacer(),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    AddressCard2(),
                    Container(
                      //height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 5),
                              child: const Text(
                                'Nome',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            padding: const EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: TextFormField(
                              // ignore: unnecessary_string_interpolations
                              initialValue: '${userManager.user.name}',
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nome',
                                icon: Icon(
                                  Icons.people,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 5),
                              child: const Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            padding: const EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: TextFormField(
                              // ignore: unnecessary_string_interpolations
                              initialValue: '${userManager.user.email}',
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.alternate_email,
                                  color: Colors.grey,
                                ),
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 5),
                              child: const Text(
                                'Telefone',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            padding: const EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.phone_android,
                                  color: Colors.grey,
                                ),
                                hintText: 'Telefone',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 5),
                              child: const Text(
                                'Alterar Senha',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            padding: const EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey,
                                ),
                                hintText: 'Alterar Senha',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 45,
                            child: FlatButton(
                              onPressed: () {},
                              color: Colors.transparent,
                              child: Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 28, 57, 24),
                                      Colors.green
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Salvar'.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
