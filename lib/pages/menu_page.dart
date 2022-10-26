// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gravini/models/usuario.dart';
import 'package:gravini/providers/statusMenuFlotante.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../helpers/mostrar_alerta.dart';
import '../services/usuarios_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    authService.getCurrentUser();
    final user = authService.usuario;
    return authService.getAutenticando == true
        ? _loading()
        : menuView(user: user);
  }
}

class _loading extends StatelessWidget {
  const _loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('CARGANDO IMAGEN'),
                ],
                isRepeatingAnimation: true,
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 25,
            ),
            DefaultTextStyle(
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText('It is not enough to do your best,'),
                  TyperAnimatedText('you must know what to do,'),
                  TyperAnimatedText('and then do your best'),
                  TyperAnimatedText('- W.Edwards Deming'),
                ],
                onTap: () {},
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class menuView extends StatelessWidget {
  const menuView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Usuario? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(children: [
        infoUser(user: user),
        const SizedBox(
          height: 20,
        ),
        const _subMenu(),
      ]),
    );
  }
}

class infoUser extends StatelessWidget {
  const infoUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Usuario? user;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Center(
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Stack(children: [
          CircleAvatar(
            backgroundImage: user?.imagenPerfil == null
                ? const AssetImage('assets/images.png') as ImageProvider
                : NetworkImage(user!.imagenPerfil!),
            backgroundColor: Colors.blue[100],
            maxRadius: 65,
          ),
          Stack(
              alignment: AlignmentDirectional.bottomCenter,
              fit: StackFit.loose,
              children: [
                Container(
                    child: RawMaterialButton(
                  child: Icon(
                    Icons.camera_alt,
                    size: 60.0,
                    color: Colors.transparent,
                  ),
                  padding: EdgeInsets.all(35.0),
                  elevation: 2.0,
                  fillColor: Colors.transparent,
                  shape: CircleBorder(),
                  onPressed: () {},
                )),
                RawMaterialButton(
                  onPressed: () async {
                    final picker = new ImagePicker();
                    final PickedFile? pickedFile = await picker.getImage(
                        source: ImageSource.gallery, imageQuality: 50);

                    if (pickedFile == null) {
                      return;
                    }
                    user?.imagenPerfil = pickedFile.path;
                    authService.updateSelectedImageUser(pickedFile.path);

                    authService.actualizarImg();
                  },
                  elevation: 2.0,
                  fillColor: Colors.blue,
                  child: Icon(
                    Icons.camera_alt,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(10.0),
                  shape: CircleBorder(),
                )
              ])
        ]),
        const SizedBox(
          height: 20,
        ),
        Text(
          user!.nombre!,
          style: const TextStyle(
              color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}

class _subMenu extends StatefulWidget {
  const _subMenu({Key? key}) : super(key: key);

  @override
  State<_subMenu> createState() => _subMenuState();
}

class _subMenuState extends State<_subMenu> {
  ScrollController controller = ScrollController();
  double scrollAnterior = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => statusMenu(),
      child: Container(
        margin: const EdgeInsets.only(top: 160),
        child: _listSubMenu(controller: controller),
      ),
    );
  }
}

class _listSubMenu extends StatefulWidget {
  const _listSubMenu({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  State<_listSubMenu> createState() => _listSubMenuState();
}

class _listSubMenuState extends State<_listSubMenu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      children: [
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            _itemMenu(
              icono: FontAwesomeIcons.lock,
              texto: "Cambiar contraseña",
              onPressr: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => _alertChangedPassword());
              },
            ),
            _itemMenu(
              icono: FontAwesomeIcons.doorOpen,
              texto: "Cerrar Sesión",
              onPressr: () {
                Navigator.pushReplacementNamed(context, 'login');
                AuthService.deleteToken();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _alertChangedPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> formValues = {'user': '', 'pass': ''};
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    return AlertDialog(
      icon: Icon(
        FontAwesomeIcons.lock,
        size: 60,
        color: Colors.grey[400],
      ),
      title: const Text('Cambio de cosntraseña'),
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                    key: myFormKey,
                    child: Column(children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        obscureText: true,
                        initialValue: "",
                        onChanged: (value) {
                          formValues['pass'] = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Este campo es requerido';
                          }
                          return value.length < 3 ? 'Mínimo de 3 letras' : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                            hintText: 'Ingrese su nueva contraseña',
                            labelText: 'Nueva Contraseña',
                            prefixIcon: Icon(Icons.lock),
                            prefixStyle: TextStyle(height: 300)),
                      ),
                      //Separacion
                      const SizedBox(
                        height: 20,
                      ),
                      //Campo de Apellido Paterno
                    ]))),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () async {
              //Servicio de cambio de contraseña
              final usuariosService = UsuariosService();
              final exitoso =
                  await usuariosService.upDataPass(formValues['pass']!);

              if (exitoso) {
                _mostrarAlerta(context, 'Cambio de contraseña',
                    'Cambio de contraseña exitoso');
              } else {
                _mostrarAlerta(context, 'Cambio de contraseña',
                    'Fallo el cambio de contraseña');
              }
            },
            child: const Text('Cambiar Contraseña')),
      ],
    );
  }
}

_mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(titulo),
              content: Text(subtitulo),
              actions: <Widget>[
                MaterialButton(
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, 'menu'),
                    child: const Text('Ok'))
              ],
            ));
  }

  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'menu'),
                  child: const Text('Ok'))
            ],
          ));
}

ButtonStyle _styleButton() {
  return ButtonStyle(
      enableFeedback: true, tapTargetSize: MaterialTapTargetSize.shrinkWrap);
}

class _itemMenu extends StatelessWidget {
  final String texto;
  final void Function() onPressr;
  final IconData icono;

  const _itemMenu(
      {Key? key,
      required this.texto,
      required this.onPressr,
      required this.icono})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextButton(
        style: _styleButton(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: onPressr,
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Icon(icono, color: Colors.black26),
            const SizedBox(
              width: 10,
            ),
            Text(
              texto,
              style: const TextStyle(
                  leadingDistribution: TextLeadingDistribution.proportional,
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
