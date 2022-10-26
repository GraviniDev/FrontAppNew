import 'package:gravini/global/environment.dart';
import 'package:gravini/models/obtenerUsuarios_response.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/usuario.dart';
import '../providers/db_provider.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuario() async {
    try {
      final token = await AuthService.getToken();
      final uri = Uri.parse('${Enviroment.apiUrl}/ObtenerUsuarios');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'authToken': token ?? "u"
      });

      final obtenerUsuarioResponse = obtenerUsuariosResponseFromJson(resp.body);
      if (resp.statusCode == 200) {
        if (obtenerUsuarioResponse.code == 0) {
          return obtenerUsuarioResponse.data!;
        }
      } else {
        return [];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Usuario>> getUsersChat() async {
    try {
      final token = await AuthService.getToken();
      final uri = Uri.parse('${Enviroment.apiUrl}/obtenerUsuariosInt');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'authToken': token ?? "u"
      });

      final obtenerUsuarioResponse = obtenerUsuariosResponseFromJson(resp.body);
      if (resp.statusCode == 200) {
        if (obtenerUsuarioResponse.code == 0) {
          return obtenerUsuarioResponse.data!;
        }
      } else {
        return [];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Usuario>> searchUsers(String query) async {
    try {
      List<Usuario> listUsuarios = await getUsuario();
      return listUsuarios
          .where((i) => i.nombre!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> upDataPass(String pass) async {
    try {
      final token = await AuthService.getToken();
      final email = await AuthService.getEmail();
      final data = {'correo': email, 'password': pass};
      final uri = Uri.parse('${Enviroment.apiUrl}/actualizaPass');
      final resp = await http.put(uri, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
        'authToken': token ?? "u"
      });

      if (resp.statusCode == 200) {
        //Es correcto
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
