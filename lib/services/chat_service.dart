import 'package:flutter/material.dart';
import 'package:gravini/global/environment.dart';
import 'package:gravini/models/mensajes_response.dart';
import 'package:gravini/models/usuario.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future getChat(String usuarioID) async {
    final token = await AuthService.getToken();

    final uri = Uri.parse(
        '${Enviroment.apiUrl}/obtenerHistorial/?uidUserAbierto=$usuarioID');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'authToken': token ?? "u"
    });
    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.data;
  }
}
