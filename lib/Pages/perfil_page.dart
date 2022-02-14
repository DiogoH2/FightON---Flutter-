import 'package:Fighton/classes/app_routes.dart';
import 'package:Fighton/classes/usuario.dart';
import 'package:Fighton/repository/repository_user.dart';
import 'package:Fighton/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

import 'login_page.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PefilPageState createState() => _PefilPageState();
}

class _PefilPageState extends State<PerfilPage> {
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  bool _ocupado = false;
  List<Usuario> _listaUsuario = List<Usuario>();
  RepositoryUsuario rep = RepositoryUsuario();

  Future consultaUsuario() async {
    this._listaUsuario = await rep.getClientePerfil();
    this._ocupado = false;
    setState(() {});
  }

  @override
  void initState() {
    consultaUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('PERFIL'),
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
      body: Visibility(
        visible: _ocupado,
        child: Container(
          child: Loader(texto: 'Carregando...'),
        ),
        replacement: ListView.builder(
          padding: EdgeInsets.only(left: 0, top: 50, right: 0),
          itemCount: _listaUsuario.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(55),
                  side: BorderSide(color: Colors.black, width: 4)),
              child: ListTile(
                minVerticalPadding: 22.0,
                isThreeLine: true,
                title: Text(_listaUsuario[index].nome,
                    style: GoogleFonts.dmSerifDisplay(
                        fontSize: 40,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(
                              3,
                              1,
                            ),
                          )
                        ],
                        fontWeight: FontWeight.bold)),
                subtitle: Text(
                    '\n' +
                        'EMAIL ' +
                        '\n' +
                        _listaUsuario[index].email +
                        '\n \n' +
                        'IDADE ' +
                        '\n' +
                        _listaUsuario[index].data +
                        '\n \n' +
                        'CELULAR' +
                        '\n' +
                        _listaUsuario[index].celular +
                        '\n \n' +
                        'ESTADO' +
                        '\n' +
                        _listaUsuario[index].estado +
                        '\n \n' +
                        'CIDADE ' +
                        '\n' +
                        _listaUsuario[index].cidade,
                    style: GoogleFonts.breeSerif(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: Colors.black,
                    )),
                trailing: Container(
                  width: 56,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, size: 45.0),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(
                            AppRoutes.PAGE_EDIT,
                            arguments: _listaUsuario[index],
                          )
                              .then((retorno) {
                            if (retorno) {
                              consultaUsuario();
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
                leading: CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage(
                    _listaUsuario[index].image,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
