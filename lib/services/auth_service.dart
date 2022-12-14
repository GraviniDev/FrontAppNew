import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:gravini/global/environment.dart';
import 'package:gravini/models/login_response.dart';
import 'package:gravini/models/obtenerUsuarios_response.dart';
import 'package:gravini/models/usuario.dart';
import 'package:http/http.dart' as http;

import '../models/datos_usuarios_curp.dart';
import '../providers/db_provider.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  DataUser? dataCurp;
  List<Usuario>? listUsuarioConectados;
  File? newPictureFile;
  List<Usuario> usersConnected = [];

  void obtenerUserConectados(List<Usuario> listUser) async {
    this.listUsuarioConectados = await listUser;
  }

  void getUserConnected(List<Usuario> listUsers) async {
    this.usersConnected = [];
    this.usersConnected = await listUsers;
  }

  List<Usuario>? listUsuario;
  bool _autenticando = false;
// Create storage
  final _storage = const FlutterSecureStorage();

  void getCurrentUser() async {
    this.usuario = await DBProvider.db.getUsuario();
  }

//Getters del token en forma estatica
  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<String?> getTokenFireBase() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'tokenFireBase');
    return token;
  }

  static Future<String?> getpass() async {
    const storage = FlutterSecureStorage();
    final pass = await storage.read(key: 'pass');
    return pass;
  }

  static Future<String?> getEmail() async {
    const storage = FlutterSecureStorage();
    final email = await storage.read(key: 'email');
    return email;
  }

  static Future<String?> deleteToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.delete(key: 'token');
    final pass = await storage.delete(key: 'pass');
    final email = await storage.delete(key: 'email');
    return null;
  }

  bool? get getAutenticando => _autenticando;
  set setAutenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  Future login(String email, String password) async {
    try {
      _autenticando = true;
      final data = {'correo': email, 'password': password};
      final uri = Uri.parse('${Enviroment.apiUrl}/auth/login');
      final resp = await http.post(uri,
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});

      final loginResponse = loginResponseFromJson(resp.body);

      if (loginResponse.respuesta!.code == 0) {
        usuario = loginResponse.respuesta!.data!.user;
        await _guardarToken(loginResponse.respuesta!.data!.token!);
        await _guardarPass(password);
        await _guardarEmail(email);
        await DBProvider.db.nuevoUser(usuario);
        await saveTokenFireBase();
        _autenticando = false;
        return true;
      } else {
        _autenticando = false;
        return false;
      }
    } catch (e) {
      _autenticando = false;
    }
  }

  Future saveTokenFireBase() async {
    try {
      _autenticando = true;
      final token = await _storage.read(key: 'token');
      final data = {'tokenFireBase': await _storage.read(key: 'tokenFireBase')};
      final uri = Uri.parse('${Enviroment.apiUrl}/auth/guardarTokenFB');
      final resp = await http.put(uri, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
        'authToken': token ?? "u"
      });
    } catch (e) {}
  }

  Future registro(
    String nombre,
    String apellidoPaterno,
    String apellidoMaterno,
    String curp,
    String numeroCelular,
    String estadoResidencia,
    String fechaNacimiento,
    bool esEgresado,
    int anioIngreso,
    String campusVilla,
    String correo,
    int rol,
    bool estado,
    String password,
  ) async {
    setAutenticando = true;

    final uri = Uri.parse('${Enviroment.apiUrl}/registroUsuarios');
    final newUser;
    if (this.newPictureFile == null) {
      newUser = http.MultipartRequest('POST', uri)
        ..fields['nombre'] = nombre
        ..fields['apellidoPaterno'] = apellidoPaterno
        ..fields['apellidoMaterno'] = apellidoMaterno
        ..fields['curp'] = curp
        ..fields['numeroCelular'] = numeroCelular
        ..fields['estadoResidencia'] = estadoResidencia
        ..fields['fechaNacimiento'] = fechaNacimiento.substring(0, 11)
        ..fields['esEgresado'] = esEgresado.toString()
        ..fields['anioIngreso'] = anioIngreso.toString()
        ..fields['campusVilla'] = campusVilla
        ..fields['correo'] = correo
        ..fields['password'] = password
        ..fields['rol'] = rol.toString()
        ..fields['estado'] = estado.toString();
    } else {
      final file =
          await http.MultipartFile.fromPath('image', newPictureFile!.path);

      newUser = http.MultipartRequest('POST', uri)
        ..fields['nombre'] = nombre
        ..fields['apellidoPaterno'] = apellidoPaterno
        ..fields['apellidoMaterno'] = apellidoMaterno
        ..fields['curp'] = curp
        ..fields['numeroCelular'] = numeroCelular
        ..fields['estadoResidencia'] = estadoResidencia
        ..fields['fechaNacimiento'] = fechaNacimiento.substring(0, 11)
        ..fields['esEgresado'] = esEgresado.toString()
        ..fields['anioIngreso'] = anioIngreso.toString()
        ..fields['campusVilla'] = campusVilla
        ..fields['correo'] = correo
        ..fields['password'] = password
        ..fields['rol'] = rol.toString()
        ..fields['estado'] = estado.toString()
        ..files.add(file);
    }

    newUser.headers['Content-Type'] = "application/json";

    var streamResponse = await newUser.send();
    // final resp = await http.post(uri,
    //     body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.body != "") {
      final respBody = jsonDecode(resp.body);
      _autenticando = false;
      return respBody['error'];
    }

    _autenticando = false;
  }

  Future<bool> isLoggedIn() async {
    try {
      final token = await _storage.read(key: 'token');
      final uri = Uri.parse('${Enviroment.apiUrl}/ObtenerUsuarios');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'authToken': token ?? "u"
      });
      final obtenerUsuarioResponse = obtenerUsuariosResponseFromJson(resp.body);
      if (resp.statusCode == 200) {
        if (obtenerUsuarioResponse.code == 0) {
          listUsuario = obtenerUsuarioResponse.data;

          return true;
        } else {
          final email = await _storage.read(key: 'email');
          final pass = await _storage.read(key: 'pass');
          final resp = await login(email!, pass!);
          return resp;
        }
      } else {
        logout();
        return false;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future _guardarToken(String token) async {
// Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future _guardarPass(String pass) async {
// Write value
    return await _storage.write(key: 'pass', value: pass);
  }

  Future _guardarEmail(String email) async {
// Write value
    return await _storage.write(key: 'email', value: email);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'pass');
    await _storage.delete(key: 'email');
  }

  Future validarCurp(String curp) async {
    try {
      _autenticando = true;
      final data = {'curp': curp};
      final uri = Uri.parse('${Enviroment.apiUrl}/validarCurp?curp=$curp');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final loginResponse = mensajesResponseFromJson(resp.body);

      if (loginResponse.code == 0) {
        dataCurp = loginResponse.data!;

        _autenticando = false;
        return true;
      } else {
        _autenticando = false;
        return false;
      }
    } catch (e) {
      _autenticando = false;
    }
  }

  Future validarName(String nombre) async {
    try {
      _autenticando = true;
      final uri = Uri.parse(
          '${Enviroment.apiUrl}/validarPorNombre?nombreCompleto=$nombre');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final loginResponse = mensajesResponseFromJson(resp.body);

      if (loginResponse.code == 0) {
        dataCurp = loginResponse.data!;

        _autenticando = false;
        return true;
      } else {
        _autenticando = false;
        return false;
      }
    } catch (e) {
      _autenticando = false;
    }
  }

  void updateSelectedImageUser(String path) {
    this.newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future actualizarImg() async {
    setAutenticando = true;
    final token = await _storage.read(key: 'token');
    final uri = Uri.parse('${Enviroment.apiUrl}/actualizaImgperfil');
    final newUser;

    final file =
        await http.MultipartFile.fromPath('image', newPictureFile!.path);

    newUser = http.MultipartRequest('put', uri)..files.add(file);

    newUser.headers['Content-Type'] = "application/json";
    newUser.headers['authToken'] = token ?? "u";

    var streamResponse = await newUser.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.body != "") {
      final respBody = jsonDecode(resp.body);
      final email = await _storage.read(key: 'email');
      final pass = await _storage.read(key: 'pass');
      final resp1 = await login(email!, pass!);
      _autenticando = false;
      notifyListeners();

      return respBody['error'];
    }

    _autenticando = false;
    notifyListeners();
  }
}
