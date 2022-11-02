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

  Oraciones? _prayerDetail;

  Oraciones? get getPrayerDetail => _prayerDetail;

  set setPrayerDetail(Oraciones prayerDetail) {
    _prayerDetail = prayerDetail;
  }

  Future getOraciones() async {
    final uri = Uri.parse(
        'https://gravini-notificaciones-default-rtdb.firebaseio.com/Oraciones/$_Titulo.json');

    final resp =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    String body = resp.body;
    if (body.length != 2) {
      final mensajesResp = oracionesFromJson(resp.body);

      List<Oraciones> listprevia =
          mensajesResp.entries.map((e) => e.value).toList();

      return listprevia;
    } else {
      List<Oraciones> dbUsuario = [];
      return dbUsuario;
    }
  }
}
