import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/Helpers/validators.dart';
import 'package:saudavel_life_v2/models/user.dart';
import 'package:provider/provider.dart';
import 'package:saudavel_life_v2/models/user_manager.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Usuario user = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      // ignore: missing_return
                      validator: (name) {
                        if (name.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (name.trim().split(' ').length <= 1) {
                          return 'Preencha seu nome completo';
                        }
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      enabled: !userManager.loading,
                      autocorrect: false,
                      decoration: const InputDecoration(hintText: 'E-Mail'),
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (!emailValid(email)) return 'E-mail inválido';
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: true,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      validator: (pass) {
                        if (pass.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (pass.length < 6) {
                          return 'Senha deve ter mais que 6 digitos';
                        }
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: true,
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Senha Novamente'),
                      validator: (pass2) {
                        if (pass2.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (pass2.length < 6) {
                          return 'Senha deve ter mais que 6 digitos';
                        }
                        return null;
                      },
                      onSaved: (pass2) => user.password2 = pass2,
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  if (user.password != user.password2) {
                                    scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content:
                                            const Text('Senhas diferentes'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return null;
                                  }
                                  userManager.signUp(
                                    usuario: user,
                                    onSuccess: () {
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Falha ao cadastrar: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Criar Conta',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
