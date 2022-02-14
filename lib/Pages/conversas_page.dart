import 'package:Fighton/Pages/login_page.dart';
import 'package:Fighton/Pages/matchteste.dart';
import 'package:Fighton/classes/app_routes.dart';
import 'package:Fighton/classes/usuario.dart';
import 'package:Fighton/repository/repository_user.dart';
import 'package:Fighton/widgets/Loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ConversasPage extends StatefulWidget {
  @override
  _ConversasPageState createState() => _ConversasPageState();
}

class _ConversasPageState extends State<ConversasPage> {
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
                  MaterialPageRoute(builder: (context) => MatchPage()),
                );
                SizedBox(
                  height: 10,
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
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('Conversas'),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: Icon(Icons.people)),
          body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Conversa').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: snapshot.data.docs.map((document) {
                  nome = document['Nome'];
                  idade = document['Idade'];
                  url = document['ImageURL'];
                  return Container(
                    child: Card(
                      child: ListTile(
                        title: Text(nome),
                        subtitle:
                            Text('Mesagem', style: TextStyle(fontSize: 14.5)),
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            url,
                          ),
                        ),
                        trailing: Container(
                          width: 60,
                          child: Row(
                            children: [
                              FloatingActionButton(
                                backgroundColor: Color(0xff393e46),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.CHAT_SCREEN);
                                },
                                child: Icon(
                                  Icons.east_outlined,
                                  size: 35.0,
                                  color: Color(0xffd0af84),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
