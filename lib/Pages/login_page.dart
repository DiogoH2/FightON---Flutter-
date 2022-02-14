import 'package:Fighton/Pages/matchteste.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'cadastro_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Autenticação
  String _email, _password;
  final auth = FirebaseAuth.instance;

  TextEditingController _emailLoginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.none,
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(right: 340, left: 10),
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.transparent,
              onPressed: () {
                _showMyDialog();
              },
              child: Icon(Icons.info_sharp, color: Colors.white, size: 36.0)),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          width: 370,
          height: 480,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset(
                  'images/logo2.jpg',
                  width: 130,
                  height: 130,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      icon: Icon(
                        Icons.email,
                      )),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Senha',
                      icon: Icon(
                        Icons.lock,
                      )),
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonTheme(
                    minWidth: 110.0,
                    height: 45.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print(
                                'Nenhum usuário encontrado para esse e-mail.');
                          } else if (e.code == 'wrong-password') {
                            print('Senha errada fornecida para esse usuário.');
                          }
                        }

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MatchPage()));
                        // LOGIN --- auth.signInWithEmailAndPassword(
                        //     email: _email, password: _password);
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 110.0,
                    height: 45.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                      child: Text(
                        'CADASTRO',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CadastroPage()));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sobre'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Nosso objetivo é possibilitar aos usuários organizarem uma luta entre si com as devias regras estabelecidas, onde o lutador tem a opção de aceitar ou recusar a luta.'),
                Padding(padding: EdgeInsets.only(top: 12.0)),
                Text(
                    'Caso os dois usuários confirmem a luta, é marcada o lugar e a luta é iniciada.'),
                Padding(padding: EdgeInsets.only(top: 12.0)),
                Text(
                    'Quando a luta é finalizada, o vencedor ganha pontos no ranking do aplicativo.')
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              child: Text('OK'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
