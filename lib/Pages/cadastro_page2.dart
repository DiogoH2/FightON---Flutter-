import 'dart:io';
import 'package:Fighton/Pages/camera_composer.dart';
import 'package:Fighton/Pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CadastroPage2 extends StatefulWidget {
  @override
  _CadastroPage2 createState() => _CadastroPage2();
}

class _CadastroPage2 extends State<CadastroPage2> {
  // FIREBASE
  bool _initialized = false;
  bool _error = false;

  File  imagem;


  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

   gravarFirestore() {
    FirebaseFirestore.instance.collection('usuarios').doc(_email).set({
      'imageURL':  basename(imagem.path),
      
     
    });
   }
    String _email;
    final auth = FirebaseAuth.instance;
// FIREBASE

void pegarimagemGaleria() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState((){
      imagem = File(pickedFile.path);
    });
  }

  void pegarimagemCamera() async {
     final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState((){
      imagem = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(imagem.path);
   Reference  firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imagem);
    uploadTask.then((res){
      res.ref.getDownloadURL();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: imagem != null ?CircleAvatar(
                radius:150, 
                child: ClipOval(
                  child: Image.file(imagem),
              ),
             ) : Center(child:Text('Selecione uma imagem'),
              ),
            ),
             
          ),          
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
     children: [
       SizedBox(
           width: 100,
         ),
       IconButton(
         icon: Icon(Icons.camera_alt,
           size: 40,
           color: Colors.green),
         onPressed: (){
           pegarimagemCamera();
         },
       ),
        IconButton(
         icon: Icon(Icons.image,
           size: 40,
           color: Colors.blue),
         onPressed: (){
           pegarimagemGaleria();
         },
       ),
        SizedBox(
           width: 100,
         ),
       IconButton(
         icon: Icon(Icons.archive,
           size: 40,
           color: Colors.black),
         onPressed: (){
           uploadImageToFirebase();
           gravarFirestore();
           Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
         },),
     ],
    ),
        ],),
     );
   
  }
}
