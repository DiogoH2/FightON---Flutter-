import 'package:Fighton/Pages/login_page.dart';
import 'package:Fighton/classes/app_routes.dart';
import 'package:Fighton/classes/usuario.dart';
import 'package:Fighton/repository/repository_user.dart';
import 'package:Fighton/widgets/Loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<String> tinderimages = [
    "images/luffy.jpg",
    "images/naruto.jpg",
    "images/ZeroTwo.jpg",
    "images/girl.png",
  ];
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  bool _ocupado = false;
  List<Usuario> _listaUsuario = List<Usuario>();
  RepositoryUsuario rep = RepositoryUsuario();

  Future consultaUsuario() async {
    this._listaUsuario = await rep.getCliente();
    this._ocupado = false;
    setState(() {});
  }

  Future toFirebase() async {
    FirebaseFirestore.instance.collection('Conversa').add({
      'Nome': nome,
      'Idade': idade,
      'ImageURL': url,
    });
  }

  @override
  void initState() {
    consultaUsuario();
    super.initState();
  }

  String nome;
  String idade;
  String url;
  String estado;
  String cidade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Image.asset(
                  'images/logo.png',
                  width: 50,
                  height: 50,
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.chat,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.CONVERSAS_PAGE);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.PERFIl_PAGE);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.person_pin_circle,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.PROXIMOS_PAGE);
                  }),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 25)),
              ListTile(
                leading: Icon(
                  Icons.person_pin_rounded,
                  color: Colors.lightGreen,
                ),
                title: Text(user.email),
                // FirebaseAuth.instance.currentUser.email;
                onTap: () {
                  // Navigator.of(context).pushNamed(AppRoutes.CHAT_PAGE);
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.chat),
              //   title: Text('Chat'),
              //   onTap: () {
              //     Navigator.of(context).pushNamed(AppRoutes.CHAT_SCREEN);
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Perfil'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.PERFIl_PAGE);
                },
              ),
              ListTile(
                leading: Icon(Icons.sports_mma),
                title: Text('Match'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.MATCH_PAGE);
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Conversas'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.CONVERSAS_PAGE);
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Pessoas próximas'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.PROXIMOS_PAGE);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text('Sair'),
                onTap: () {
                  auth.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              )
            ],
          ),
        ),
        body: Container(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(), //
              itemCount: _listaUsuario.length,
              itemBuilder: (BuildContext context, int index) {
                nome = _listaUsuario[index].nome;
                idade = _listaUsuario[index].data;
                url = _listaUsuario[index].image;

                return Column(children: [
                  Padding(padding: EdgeInsets.only(top: 60)),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: TinderSwapCard(
                      orientation: AmassOrientation.TOP,
                      totalNum: 1,
                      stackNum: 5,
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.width * 0.9,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      minHeight: MediaQuery.of(context).size.width * 0.8,
                      cardBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0, color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                  _listaUsuario[index].image,
                                ),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 16, bottom: 18),
                                    child: Text(
                                      _listaUsuario[index].nome +
                                          '\n' +
                                          _listaUsuario[index].data +
                                          ' anos'
                                              '\n' +
                                          _listaUsuario[index].estado +
                                          '\n' +
                                          _listaUsuario[index].cidade,
                                      style: GoogleFonts.montserrat(
                                          letterSpacing: 0,
                                          fontSize: 15,
                                          color: Colors.black,
                                          shadows: [
                                            Shadow(
                                              color: Colors.grey,
                                              offset: Offset(
                                                1,
                                                2,
                                              ),
                                            )
                                          ],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FlatButton(
                                  height: 55,
                                  minWidth: 95,
                                  child: Text('NO',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(38.0),
                                      side: BorderSide(
                                        width: 2,
                                        color: Colors.red,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      _listaUsuario
                                          .removeWhere((tinderSwapCard) {
                                        return (tinderSwapCard).id ==
                                            _listaUsuario[index].id;
                                      });
                                    });
                                  },
                                ),
                                FlatButton(
                                  height: 55,
                                  minWidth: 95,
                                  child: Text(
                                    'YES',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(38.0),
                                      side: BorderSide(
                                          width: 2, color: Colors.green)),
                                  onPressed: () {
                                    toFirebase();
                                    setState(() {
                                      _listaUsuario
                                          .removeWhere((tinderSwapCard) {
                                        return (tinderSwapCard).id ==
                                            _listaUsuario[index].id;
                                      });
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                ]);
              }),
        ));
  }
}
