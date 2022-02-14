import 'package:Fighton/Pages/cadastro_page.dart';
import 'package:Fighton/Pages/edit_page.dart';
import 'package:Fighton/Pages/login_page.dart';
import 'package:Fighton/Pages/proximos_page.dart';
import 'package:Fighton/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Pages/conversas_page.dart';
import 'Pages/matchteste.dart';
import 'Pages/perfil_page.dart';
import 'classes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FightON',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
        routes: {
          AppRoutes.MATCH_PAGE: (_) => MatchPage(),
          AppRoutes.CHAT_SCREEN: (_) => ChatScreen(),
          AppRoutes.PERFIl_PAGE: (_) => PerfilPage(),
          AppRoutes.CONVERSAS_PAGE: (_) => ConversasPage(),
          AppRoutes.PAGE_EDIT: (_) => EditPage(),
          AppRoutes.PROXIMOS_PAGE: (_) => ProximosPage(),
        });
  }
}
