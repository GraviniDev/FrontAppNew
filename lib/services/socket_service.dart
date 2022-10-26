import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gravini/global/environment.dart';
import 'package:gravini/services/auth_service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;
  ServerStatus get getserverStatus => _serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this.socket.emit;
  Function get on => this.socket.on;

  ///Conectar cada que entre a usuarios
  ///y desconectar cuando salga

  void connect() async {
    final token = await AuthService.getToken();
    this._socket = IO.io(Enviroment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'authToken': token}
    });

    this._socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
      print('connect');
    });
    this._socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
    // _socket.on('enviar-mensaje', (payload) {});
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
