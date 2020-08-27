import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/models/page_manager.dart';
import 'package:saudavel_life_v2/models/user_manager.dart';

import '../../models/user.dart';
import '../../models/user_manager.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 230,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (userManager.isLoggedIn) CircularAvatar() else SaudavelApp(),
              Text(
                'Olá, ${userManager.user?.name ?? ''}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (userManager.isLoggedIn) {
                    context.read<PageManager>().setPage(0);
                    userManager.signOut();
                  } else {
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(
                  userManager.isLoggedIn ? 'Sair' : 'Entre ou Cadastre-se >',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SaudavelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '        Loja \nSaudavel Life',
      style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    );
  }
}

// ignore: must_be_immutable
class CircularAvatar extends StatelessWidget {
  CircularAvatar(
      {this.user, this.userManager, this.radiusImg, this.radiusBord});
  User user;
  UserManager userManager;
  double radiusImg = 50;
  double radiusBord = 53;

  @override
  Widget build(BuildContext context) {
    const String tamanho = '?height=200';
    const String fotoz =
        'https://firebasestorage.googleapis.com/v0/b/saudavel-life-v2.appspot.com/o/saudavellife.png?alt=media&token=ed4232a4-4ade-49ce-82c6-5f89bcc37187';
    return Consumer<UserManager>(
      builder: (_, userManager, __) {
        return Container(
          padding: const EdgeInsets.only(bottom: 2),
          child: CircleAvatar(
            radius: 53,
            backgroundColor: Colors.white,
            child: CircleAvatar(
                foregroundColor: Colors.white,
                radius: 50,
                backgroundColor: Colors.green[800],
                backgroundImage: NetworkImage(
                  '${userManager.user?.foto + tamanho ?? fotoz}',
                )),
          ),
        );
      },
    );
  }
}
