import 'dart:io';

import 'package:Fighton/classes/usuario.dart';
import 'package:Fighton/utils/ddl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Fighton/Pages/login_page.dart';

final auth = FirebaseAuth.instance;
final user = FirebaseAuth.instance.currentUser;

class RepositoryUsuario {
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_TABLE_CLIENTE);
      },
      version: 1,
    );
  }

  Future<List<Usuario>> getCliente() async {
        String userLogado = user.email;
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> map =
          await db.query('usuario',orderBy: 'nome DESC', where: 'email != ?', whereArgs: ["$userLogado"]);
      return List.generate(map.length, (index) {
        return Usuario.fromMap(map[index]);
      });
    } catch (e) {
      print(e);
      return List<Usuario>();
    }
  }

  Future<List<Usuario>> getClientePerfil() async {
    String userLogado = user.email;
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> map = await db.query('usuario',
          orderBy: 'id DESC', where: 'email == ?', whereArgs: ["$userLogado"]);
      return List.generate(map.length, (index) {
        return Usuario.fromMap(map[index]);
      });
    } catch (e) {
      print(e);
      return List<Usuario>();
    }
  }

  Future<List<Usuario>> getClienteProximos() async {
      String userLogado = user.email;
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> map =
          await db.query('usuario',orderBy: 'nome DESC', where: 'email != ?', whereArgs: ["$userLogado"]);
      return List.generate(map.length, (index) {
        return Usuario.fromMap(map[index]);
      });
    } catch (e) {
      print(e);
      return List<Usuario>();
    }
  }

  Future insertCliente(Usuario usuario) async {
    
    try {
      final Database dbMatch = await _getDatabase();
      await dbMatch .insert('usuario', usuario.toMap());
    } catch (e) {}
  }

  Future updateCliente(Usuario usuario) async {
    try {
      final Database db = await _getDatabase();
      await db.update('usuario', usuario.toMap(),
          where: 'id = ?', whereArgs: [usuario.id]);
    } catch (e) {
      print(e);
    }
  }

  Future deleteCliente(Usuario usuario) async {
    try {
      final Database db = await _getDatabase();
      await db.delete('usuario', where: 'id = ?', whereArgs: [usuario.id]);
    } catch (e) {
      print(e);
    }
  }
}

