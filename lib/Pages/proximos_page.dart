import 'package:Fighton/classes/app_routes.dart';
import 'package:Fighton/classes/usuario.dart';
import 'package:Fighton/repository/repository_user.dart';
import 'package:Fighton/widgets/Loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';
import 'package:Fighton/Pages/matchteste.dart';

class ProximosPage extends StatefulWidget {
  @override
  _ProximosPageState createState() => _ProximosPageState();
}

class _ProximosPageState extends State<ProximosPage> {
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  List<Usuario> _listaUsuario = List<Usuario>();
  RepositoryUsuario rep = RepositoryUsuario();
  Usuario usuario;

  Future consultaUsuario() async {
    this._listaUsuario = await rep.getClienteProximos();
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('PESSOAS PRÓXIMAS'),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.refresh),
        //       onPressed: () {
        //         setState(() {
        //           consultaUsuario();
        //         });
        //       }),
        // ],
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
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          itemCount: _listaUsuario.length,
          itemBuilder: (BuildContext context, int index) {
            nome = _listaUsuario[index].nome;
            idade = _listaUsuario[index].data;
            url = _listaUsuario[index].image;
            estado = _listaUsuario[index].estado;
            cidade = _listaUsuario[index].cidade;
            return Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text(_listaUsuario[index].nome),
                    subtitle: Text(
                        'Idade: ' +
                            _listaUsuario[index].data +
                            '\n' +
                            'Estado: ' +
                            _listaUsuario[index].estado +
                            '\n' +
                            'Cidade: ' +
                            _listaUsuario[index].cidade,
                        style: TextStyle(fontSize: 14.5)),
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        url,
                      ),
                    ),
                    trailing: Container(
                      width: 122,
                      child: Row(
                        children: [
                          FloatingActionButton(
                            backgroundColor: Color(0xff393e46),
                            onPressed: () {
                              setState(() {
                                _listaUsuario.removeWhere((card) {
                                  return card.id == _listaUsuario[index].id;
                                });
                              });
                            },
                            child: Icon(
                              Icons.close_rounded,
                              size: 35.0,
                              color: Color(0xffd0af84),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          FloatingActionButton(
                            backgroundColor: Color(0xff393e46),
                            onPressed: () {
                              setState(() {
                                toFirebase();
                                _listaUsuario.removeWhere((card) {
                                  return card.id == _listaUsuario[index].id;
                                });
                              });
                            },
                            child: Icon(
                              Icons.sports_mma_rounded,
                              size: 35.0,
                              color: Color(0xff4aa96c),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
