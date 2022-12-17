import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:gravini/global/environment.dart';
import 'package:gravini/models/login_response.dart';
import 'package:gravini/models/obtenerUsuarios_response.dart';
import 'package:gravini/models/publicaciones.dart';
import 'package:gravini/models/usuario.dart';
import 'package:http/http.dart' as http;

import '../models/datos_usuarios_curp.dart';
import '../providers/db_provider.dart';

class PostService with ChangeNotifier {
  bool _autenticando = false;
  List<Publicacion>? listPost;

// Create storage
  final _storage = const FlutterSecureStorage();

  Future savePost(String post) async {
    try {
      _autenticando = true;
      final token = await _storage.read(key: 'token');
      final data = {'body': post};
      final uri = Uri.parse('${Enviroment.apiUrl}/publish/crearPost');
      final resp = await http.post(uri, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
        'authToken': token ?? "u"
      });

      print(resp.body);
      _autenticando = false;
    } catch (e) {}
  }

  Future<List<Publicacion>> getPost() async {
    final token = await _storage.read(key: 'token');
    final data2 = {};
    final uri2 = Uri.parse('${Enviroment.apiUrl}/publish/getPost');
    final resp2 = await http.get(uri2, headers: {
      'Content-Type': 'application/json',
      'authToken': token ?? "u"
    });
    print(resp2.body);

    final loginResponse = publiacacionesFromJson(resp2.body);

    if (loginResponse.code == 0) {
      return listPost = loginResponse.data!;
    }
    return [];
  }
}
