import 'dart:io';

import 'package:gravini/models/usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();
  Future<Database?> get getDatabase async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Usuario?> getUsuario() async {
    final db = await getDatabase;
    final res = await db?.query('InfoUser');
    //final res = await db.query('InfoUser', where: 'id= ?', whereArgs: [1]);
    return res!.isNotEmpty ? Usuario.fromJsonBD(res.first) : null;
  }

  Future<int?> deleteUsuario() async {
    final db = await getDatabase;
    final res = await db?.delete('InfoUser');
    //final res = await db.query('InfoUser', where: 'id= ?', whereArgs: [1]);
    return res;
  }

  Future<int?> nuevoUser(Usuario? newUser) async {
    final db = await getDatabase;
    await deleteUsuario();
    String? nombre = newUser!.nombre;
    String? apellidoPaterno = newUser.apellidoPaterno;
    String? apellidoMaterno = newUser.apellidoMaterno;
    String? curp = newUser.curp;
    String? numeroCelular = newUser.numeroCelular;
    String? estadoResidencia = newUser.estadoResidencia;
    String? imagenPerfil = newUser.imagenPerfil;
    String? fechaNacimiento = newUser.fechaNacimiento.toString();
    String? esEgresado = newUser.esEgresado.toString();
    String? anioIngreso = newUser.anioIngreso.toString();
    String? campusVilla = newUser.campusVilla;
    String? correo = newUser.correo;
    String? rol = newUser.rol.toString();
    String? estado = newUser.estado.toString();
    String? uid = newUser.uid;
    final res = await db?.rawInsert('''
        INSERT INTO InfoUser (
          nombre, apellidoPaterno, apellidoMaterno, curp, 
          numeroCelular, estadoResidencia,imagenPerfil, fechaNacimiento, 
          esEgresado, anioIngreso, campusVilla, correo, rol,
          estado, uid) VALUES ('$nombre','$apellidoPaterno', '$apellidoMaterno', '$curp', '$numeroCelular',
           '$estadoResidencia','$imagenPerfil', '$fechaNacimiento', '$esEgresado', '$anioIngreso', '$campusVilla', '$correo', '$rol','$estado','$uid')''');
    print('Numero de resgistro en bd $res');
    return res;
  }

  Future<Database> initDB() async {
    // path de donde almacenamos la base de datos

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'GraviniDB.db');
    print(path);

    //Crear base de datos
    // version debe cambiar cada que se hace un cambio estructural a la bd para que se creen la nueva estructura,
    return await openDatabase(path, version: 4, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(''' 
    CREATE TABLE InfoUser(
               nombre TEXT, 
               apellidoPaterno TEXT,
               apellidoMaterno TEXT,
               curp TEXT,
               numeroCelular TEXT,
               estadoResidencia TEXT,
               imagenPerfil TEXT,
               fechaNacimiento TEXT,
               esEgresado TEXT,
               anioIngreso TEXT,
               campusVilla TEXT,
               correo TEXT,
               rol TEXT,
               estado TEXT,
               uid TEXT
    )
''');
    });
  }
}
