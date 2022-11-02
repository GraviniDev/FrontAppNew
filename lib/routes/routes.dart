import 'package:flutter/material.dart';
import 'package:gravini/pages/loading.dart';
import 'package:gravini/pages/login_page.dart';
import 'package:gravini/pages/home_page.dart';
import 'package:gravini/pages/mensaje_page.dart';
import 'package:gravini/pages/menu_page.dart';
import 'package:gravini/pages/oracion_page.dart';
import 'package:gravini/pages/registerCurp_page.dart';
import 'package:gravini/pages/registerDatos_page.dart';
import 'package:gravini/pages/registerName_page.dart';
import 'package:gravini/pages/registerStep2_page.dart';
import 'package:gravini/pages/register_page.dart';
import 'package:gravini/pages/spiritualDetail_page.dart';
import 'package:gravini/pages/usuarios_page.dart';

import '../pages/prayerDetail_page.dart';
import '../pages/register2_page.dart';
import '../pages/register3_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  'register2': (_) => Register2Page(),
  'register3': (_) => Register3Page(),
  'usuarios': (_) => const UsuariosPage(),
  'home': (_) => const HomePage(),
  'menu': (_) => const MenuPage(),
  'mensaje': (_) => const MensajePage(),
  'registerCurp': (_) => RegisterCurpPage(),
  'registerStep2': (_) => const RegistroStep2(),
  'registerDatos': (_) => RegisterDatosPage(),
  'registerName': (_) => RegisterNamePage(),
  'spiritualPage': (_) => SpirtualDetailPage(),
  'oracionPage': (_) => OracionPage(),
  'PlayerDetailPage': (_) => PlayerDetailPage()
};
