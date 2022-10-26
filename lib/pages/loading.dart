import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gravini/pages/login_page.dart';
import 'package:gravini/pages/home_page.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:gravini/services/socket_service.dart';
import 'package:provider/provider.dart';

import '../models/usuario.dart';

class LoadingPage extends StatelessWidget {
  List<Usuario> _userPre = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
              child: Image(image: AssetImage('assets/loading.gif')));
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    SchedulerBinding.instance.addPostFrameCallback((_) {
// CONDICION
      final socketService = Provider.of<SocketService>(context, listen: false);
      if (autenticado) {
        authService.getCurrentUser();
        socketService.connect();
        authService.obtenerUserConectados(_userPre);
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const HomePage(),
                transitionDuration: const Duration(microseconds: 0)));
      } else {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => LoginPage(),
                transitionDuration: const Duration(microseconds: 0)));
      }
    });
  }
}
