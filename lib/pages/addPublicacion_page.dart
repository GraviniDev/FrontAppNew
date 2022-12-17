import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gravini/services/publicaciones_service.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class AddPublicacionPage extends StatefulWidget {
  AddPublicacionPage({Key? key}) : super(key: key);

  @override
  State<AddPublicacionPage> createState() => _AddPublicacionPageState();
}

class _AddPublicacionPageState extends State<AddPublicacionPage> {
  final _textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final postService = Provider.of<PostService>(context);
    authService.getCurrentUser();
    final user = authService.usuario;
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 18.0)),
              onPressed: () async {
                postService.savePost(_textController.text);
                Navigator.pushReplacementNamed(context, 'home');
              },
              child: const Text('Publicar'),
            ),
          ],
          title: Text("Crear publicación",
              style: const TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black87),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      backgroundImage: user?.imagenPerfil == "null"
                          ? const AssetImage('assets/images.png')
                              as ImageProvider
                          : NetworkImage(user!.imagenPerfil!),
                      backgroundColor: Colors.blue[100],
                      maxRadius: 40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user!.nombre!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            width: 180.0,
                            height: 30.0,
                            child: ElevatedButton(
                              child: Row(children: [
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  iconSize: 15,
                                  icon: const Icon(FontAwesomeIcons.solidImage,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, 'home');
                                  },
                                ),
                                Text(
                                  "Cargar imagenes",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(5),
                                disabledBackgroundColor:
                                    Color.fromARGB(255, 195, 200, 198),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 15.0,
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flexible(
                  child: TextField(
                controller: _textController,
                scrollPadding: EdgeInsets.all(20.0),
                maxLines: 10,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: '¿Qué estas pensando?',
                ),
              )),
            )
          ],
        ));
  }
}
