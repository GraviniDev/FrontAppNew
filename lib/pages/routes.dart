import 'package:flutter/material.dart';
import 'package:gravini/pages/loading.dart';
import 'package:gravini/pages/login_page.dart';
import 'package:gravini/pages/home_page.dart';
import 'package:gravini/pages/mensaje_page.dart';
import 'package:gravini/pages/menu_page.dart';
import 'package:gravini/pages/registerCurp_page.dart';
import 'package:gravini/pages/registerStep2_page.dart';
import 'package:gravini/pages/register_page.dart';
import 'package:gravini/pages/usuarios_page.dart';

import '../pages/register2_page.dart';
import '../pages/register3_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => LoginPage(),
  'registerCurp': (_) => RegisterCurpPage(),
  'registerStep2': (_) => const RegistroStep2(),
  'loading': (_) => LoadingPage(),
  'usuarios': (_) => const UsuariosPage(),
  'home': (_) => const HomePage(),
  'menu': (_) => const MenuPage(),
  'mensaje': (_) => const MensajePage(),
};
