import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gravini/providers/mostrarMenuFlotante.dart';
import 'package:gravini/providers/registro_form_provider.dart';
import 'package:gravini/providers/statusMenuFlotante.dart';
import 'package:gravini/routes/routes.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:gravini/services/chat_service.dart';
import 'package:gravini/services/oraciones_service.dart';
import 'package:gravini/services/push_notifivations_service.dart';
import 'package:gravini/services/socket_service.dart';
import 'package:gravini/services/usuarios_service.dart';
import 'package:gravini/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PushNotificationService.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerrKey =
      new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotificationService.messagesStream.listen((message) {
      print('MyApp: $message');
      navigatorKey.currentState?.pushNamed('usuarios', arguments: message);
      final snackBar = SnackBar(content: Text(message));
      messengerrKey.currentState?.showSnackBar(snackBar);
    });
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => RegistroFormProvider()),
        ChangeNotifierProvider(create: (_) => statusMenu()),
        ChangeNotifierProvider(create: (_) => MostrarMenuModel()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => OracionesServices())
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: appRoutes,
        theme: AppTheme.lightTheme,
        navigatorKey: navigatorKey, //Navegar
        scaffoldMessengerKey: messengerrKey, //Snacks
      ),
    );
  }
}
