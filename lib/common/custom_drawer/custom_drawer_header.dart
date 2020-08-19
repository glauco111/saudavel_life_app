import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/models/page_manager.dart';
import 'package:saudavel_life_v2/models/user_manager.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (userManager.isLoggedIn) CircularAvatar() else SaudavelApp(),
              Text(
                'Olá, ${userManager.usuario?.name ?? ''}',
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

class CircularAvatar extends StatelessWidget {
  final NetworkImage foto = const NetworkImage(
      'https://scontent.fpoo2-1.fna.fbcdn.net/v/t1.0-9/58600086_2188791984541189_4677879156745175040_o.jpg?_nc_cat=102&_nc_sid=09cbfe&_nc_eui2=AeFxtISFL1NmANkWjF6L6-46fuXoLayFejd-5egtrIV6Nx2tFtkQ-elTFJvXtaytvbej20a7YwcIlEnQGA6kAcId&_nc_ohc=wlioH9MPEGAAX9xLTVa&_nc_ht=scontent.fpoo2-1.fna&oh=39418703a03fcafb1aeab34cbb61141f&oe=5F577AA1');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 2),
      child: CircleAvatar(
        radius: 53,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          foregroundColor: Colors.white,
          radius: 50,
          backgroundColor: Colors.green[800],
          backgroundImage: foto,
        ),
      ),
    );
  }
}
