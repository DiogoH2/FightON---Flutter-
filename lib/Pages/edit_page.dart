import 'package:Fighton/classes/usuario.dart';
import 'package:Fighton/repository/repository_user.dart';
import 'package:Fighton/widgets/Loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController dataNascController = TextEditingController();
  TextEditingController imgController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _ocupado = false;
  Usuario usuario;
  RepositoryUsuario rep = RepositoryUsuario();

  @override
  Widget build(BuildContext context) {
    usuario = ModalRoute.of(context).settings.arguments as Usuario;

    if (usuario != null && idController.text == '') {
      idController.text = usuario.id.toString();
      nomeController.text = usuario.nome;
      emailController.text = usuario.email;
      senhaController.text = usuario.senha;
      cidadeController.text = usuario.cidade;
      estadoController.text = usuario.estado;
      celularController.text = usuario.celular;
      dataNascController.text = usuario.data;
      imgController.text = usuario.image;
    }

    Future gravarDados() async {
      var use = Usuario(
          id: int.parse(idController.text),
          nome: nomeController.text,
          email: emailController.text,
          senha: senhaController.text,
          cidade: cidadeController.text,
          estado: estadoController.text,
          celular: celularController.text,
          data: dataNascController.text,
          image:
              imgController.text);

      return await rep.updateCliente(use);
    }

    // EDITAR PELO FIRESTORE
    editarFirestore() {
      FirebaseFirestore.instance.collection('usuarios').doc(user.email).update({
        'nome': nomeController.text,
        'senha': senhaController.text,
        'email': emailController.text,
        'cidade': cidadeController.text,
        'estado': estadoController.text,
        'celular': celularController.text,
        'idade': dataNascController.text
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('EDITAR PERFIL'),
      ),
      body: Visibility(
        visible: false,
        child: Loader(texto: 'Aguarde, gravando produto...'),
        replacement: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nomeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Preencha o nome';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      enabled: false,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Preencha o email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      enabled: false,
                      obscureText: true,
                      controller: senhaController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                      ),
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Preencha a senha';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: dataNascController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Idade',
                      ),
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Preencha a idade';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: celularController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Celular',
                      ),
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Preencha o celular';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: estadoController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Estado',
                      ),
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Preencha o Estado';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: cidadeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Cidade',
                      ),
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Preencha a Cidade';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          editarFirestore();
                          gravarDados().then((_) {
                            Navigator.of(context).pop(true);
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: Text(
                          'GRAVAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
