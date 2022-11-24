import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gravini/models/bolda_trabajo.dart';
import 'package:gravini/models/mensajes_response.dart';
import 'package:http/http.dart' as http;

import '../models/oraciones.dart';

class BolsaServices with ChangeNotifier {
  Bolsa? _bolsaDetail;

  Bolsa? get getBolsaDetail => _bolsaDetail;

  set setBolsaDetail(Bolsa bolsaDetail) {
    _bolsaDetail = bolsaDetail;
  }

  Future getJobs() async {
    final id = _bolsaDetail?.id.toString();
    final uri = Uri.parse(
        'https://gravini-notificaciones-default-rtdb.firebaseio.com/Bolsa/$id.json');

    final resp =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    String body = resp.body;
    // if (body.length != 2) {
    final mensajesResp = bolsaFromJson(resp.body);
  }
}
