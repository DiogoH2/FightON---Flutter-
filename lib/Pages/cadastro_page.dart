import 'dart:io';

import 'package:Fighton/Pages/login_page.dart';
import 'package:Fighton/classes/usuario.dart';
import 'package:Fighton/repository/repository_user.dart';
import 'package:Fighton/utils/ddl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'cadastro_page2.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Usuario usuario;
  RepositoryUsuario rep = RepositoryUsuario();

  File imagem;
  String imageUrl;

// GRAVAR NO FIRESTORE
  // gravarFirestore() {
  //   FirebaseFirestore.instance.collection('usuarios').add({
  //     'nome': nomeController.text,
  //     'senha': senhaController.text,
  //     'email': emailController.text,
  //     'cidade': cidadeController.text,
  //     'estado': estadoController.text,
  //     'celular': celularController.text,
  //     'idade': dataNascController.text,
  //     'imageURL':  basename(imagem.path),
  //   });
  //  }

  //Gravar Fotos

  void pegarimagemGaleria() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagem = File(pickedFile.path);
    });
  }

  void pegarimagemCamera() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imagem = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(imagem.path);

    Reference reference =
        FirebaseStorage.instance.ref().child("uploads/$fileName");

    UploadTask uploadTask = reference.putFile(imagem);

    uploadTask.whenComplete(() async {
      imageUrl = await (await uploadTask).ref.getDownloadURL();
      var user = Usuario(
        nome: nomeController.text,
        senha: senhaController.text,
        email: emailController.text,
        cidade: cidadeController.text,
        estado: estadoController.text,
        celular: celularController.text,
        data: dataNascController.text,
        image: imageUrl,
      );
        FirebaseFirestore.instance.collection('usuarios').add({
      'nome': nomeController.text,
      'senha': senhaController.text,
      'email': emailController.text,
      'cidade': cidadeController.text,
      'estado': estadoController.text,
      'celular': celularController.text,
      'idade': dataNascController.text,
      'imageURL':  basename(imagem.path),
    });
      return await rep.insertCliente(user);
    });

    return imageUrl.toString();
  }

//-----------------------------------------------------//

  Future uploadToFirebase() async {
    String fileName = basename(imagem.path);

    Reference reference =
        FirebaseStorage.instance.ref().child("uploads/$fileName");

    UploadTask uploadTask = reference.putFile(imagem);

    uploadTask.whenComplete(() async {
      imageUrl = await (await uploadTask).ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('usuarios').doc(_email).set({
        'nome': nomeController.text,
        'senha': senhaController.text,
        'email': emailController.text,
        'cidade': cidadeController.text,
        'estado': estadoController.text,
        'celular': celularController.text,
        'idade': dataNascController.text,
        'imageURL': imageUrl,
      });
    });
    return imageUrl.toString();
  }

  String _email, _password;
  final auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController dataNascController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: imagem != null
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60,
                          child: ClipOval(
                            child: Image.file(imagem),
                          ),
                        )
                      : Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2016/09/01/08/24/smiley-1635449_960_720.png',
                            ),
                          ),
                        ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt, size: 25, color: Colors.green),
                  onPressed: () {
                    pegarimagemCamera();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.image, size: 25, color: Colors.blue),
                  onPressed: () {
                    pegarimagemGaleria();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 360,
                    margin:
                        EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      margin: EdgeInsets.only(right: 20, left: 15),
                      child: ListView(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 2)),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: nomeController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Nome não preenchido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 0),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Nome',
                                icon: Icon(
                                  Icons.people,
                                )),
                          ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Email não preenchido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email',
                              icon: Icon(
                                Icons.email,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _email = value.trim();
                              });
                            },
                          ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          TextFormField(
                            obscureText: true,
                            controller: senhaController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Senha não preenchida';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Senha',
                              icon: Icon(
                                Icons.lock,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _password = value.trim();
                              });
                            },
                          ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: dataNascController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Idade não preenchida';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0),
                              icon: Icon(
                                Icons.calendar_today_outlined,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Idade',
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: celularController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Celular não preenchido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 0),
                                icon: Icon(
                                  Icons.phone,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Celular'),
                          ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: estadoController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Estado não preenchido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 0),
                                icon: Icon(
                                  Icons.location_city_outlined,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Estado'),
                          ),
                          Padding(padding: EdgeInsets.only(top: 2)),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: cidadeController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Cidade não preenchida';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 0),
                                icon: Icon(
                                  Icons.maps_home_work_rounded,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Cidade'),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ]),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ButtonTheme(
                    height: 42.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          auth.createUserWithEmailAndPassword(
                              email: _email, password: _password);
                          uploadImageToFirebase();
                          uploadToFirebase();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      },
                      child: Text(
                        'CADASTRAR',
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      ),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
