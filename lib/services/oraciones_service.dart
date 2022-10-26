import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gravini/models/mensajes_response.dart';
import 'package:http/http.dart' as http;

import '../models/oraciones.dart';

class OracionesServices with ChangeNotifier {
  String? _Titulo;

  String? get getTitulo => _Titulo;

  set setTitulo(String Titulo) {
    _Titulo = Titulo;
  }

  Future getOraciones() async {
    final uri = Uri.parse(
        'https://gravini-notificaciones-default-rtdb.firebaseio.com/Oraciones/Meditacion%20Diaria.json');

    final resp =
        await http.get(uri, headers: {'Content-Type': 'application/json'});
    final mensajesResp = oracionesFromJson(resp.body);

    return mensajesResp;
  }
}
