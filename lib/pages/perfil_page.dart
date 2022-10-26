import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    authService.getCurrentUser();
    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black87),
          onPressed: () {
            /*LOGOUT        
                  Navigator.pushReplacementNamed(context, 'login');
                  AuthService.deleteToken(); */
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
        backgroundColor: Colors.white,
        title: Row(children: [
          CircleAvatar(
            backgroundColor: Colors.blue[100],
            maxRadius: 22,
            child: const Text(
              'Te',
              style: TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'David Islas',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )
          // Text('Server :${socketService.getserverStatus}'),
        ]),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
          child: Column(
        children: [
          const Divider(
            height: 1,
          ),
          //TODO CAJA DE TEXTO
        ],
      )),
    );
  }
}
