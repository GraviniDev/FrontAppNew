//SHA1: 16:4E:25:33:A2:F6:BC:94:CD:4B:A6:18:58:4A:B8:DD:94:24:09:86

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? tokenPush;

  static StreamController<String> _messageStreamController =
      new StreamController.broadcast();

  static Stream<String> get messagesStream => _messageStreamController.stream;

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    _messageStreamController.sink.add(message.data['product'] ?? 'No data');
  }

  static Future<void> _onMessangeHandler(RemoteMessage message) async {
    _messageStreamController.sink.add(message.data['product'] ?? 'No data');
  }

  static Future<void> _onMessangeOpenApp(RemoteMessage message) async {
    _messageStreamController.sink.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    //push Notificarions
    await Firebase.initializeApp();
    tokenPush = await FirebaseMessaging.instance.getToken();
    print(tokenPush);

    final _storage = const FlutterSecureStorage();
    await _storage.write(key: 'tokenFireBase', value: tokenPush);

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessangeHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessangeOpenApp);
  }

  static closeStreams() {
    _messageStreamController.close();
  }
}
