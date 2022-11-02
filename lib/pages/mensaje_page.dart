import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gravini/models/mensajes_response.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:gravini/services/chat_service.dart';
import 'package:gravini/widgets/chat_mensaje.dart';
import 'package:provider/provider.dart';

import 'package:gravini/services/socket_service.dart';

class MensajePage extends StatefulWidget {
  const MensajePage({Key? key}) : super(key: key);

  @override
  State<MensajePage> createState() => _MensajePageState();
}

class _MensajePageState extends State<MensajePage>
    with TickerProviderStateMixin {
  late AuthService authService;

  late SocketService socketService;
  final _textController = new TextEditingController();
  bool _estaEscribiendo = false;
  final _focusNode = new FocusNode();
  late ChatService chatService;

  List<ChatMensaje> _messages = [];
  @override
  void initState() {
    super.initState();

    this.authService = Provider.of<AuthService>(context, listen: false);
    chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('mensaje-privado', _escucharMensaje);

    _cargarHistorial(chatService.usuarioPara.uid);
  }

  void _cargarHistorial(String? usuarioID) async {
    List<Datum> chat = await chatService.getChat(usuarioID!);
    final history = chat.reversed.map((m) => new ChatMensaje(
        texto: m.mensaje!,
        uid: m.de!,
        animationController: new AnimationController(
            vsync: this, duration: Duration(milliseconds: 0))
          ..forward()));
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic data) {
    // _messages = [];
    // List<ChatMensaje> _messagesPre = [];
    // data.forEach((item) {
    //   String msg = item['mensaje'];
    //   String id = (item['id']);

    //   ChatMensaje message = new ChatMensaje(
    //       texto: msg,
    //       uid: id,
    //       animationController: AnimationController(
    //           vsync: this, duration: Duration(milliseconds: 200)));

    //   _messagesPre.insert(0, message);
    //   message.animationController.forward();
    // });

    // _messages = _messagesPre;

    // setState(() {});
    //below is the solution

    ChatMensaje message = new ChatMensaje(
      texto: data['mensaje'],
      uid: data['de'],
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 300)),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    final usuarioPara = chatService.usuarioPara;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black87),
          onPressed: () {
            /*LOGOUT        
                  Navigator.pushReplacementNamed(context, 'login');
                  AuthService.deleteToken(); */
            Navigator.pushReplacementNamed(context, 'usuarios');
          },
        ),
        backgroundColor: Colors.white,
        title: Row(children: [
          CircleAvatar(
            backgroundColor: Colors.blue[100],
            backgroundImage: usuarioPara.imagenPerfil == null
                ? const AssetImage('assets/images.png') as ImageProvider
                : NetworkImage(usuarioPara.imagenPerfil!),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            usuarioPara.nombre!,
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
          Flexible(
              child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _messages.length,
            itemBuilder: (_, i) => _messages[i],
            reverse: true,
          )),
          const Divider(
            height: 1,
          ),
          //TODO CAJA DE TEXTO

          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      )),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (texto) {
              setState(() {
                if (texto.trim().length > 0) {
                  _estaEscribiendo = true;
                } else {
                  _estaEscribiendo = false;
                }
              });
            },
            decoration: InputDecoration(hintText: 'Enviar mensaje'),
            focusNode: _focusNode,
          )),

          // Botón de enviar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        onPressed: _estaEscribiendo
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;
    _textController.clear();
    _focusNode.requestFocus();
    final newMesage = new ChatMensaje(
      texto: texto,
      uid: authService.usuario!.uid!,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMesage);

    newMesage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });

    this.socketService.emit('mensaje-privado', {
      'de': this.authService.usuario!.uid,
      'para': this.chatService.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    for (ChatMensaje message in _messages) {
      message.animationController.dispose();
    }

    this.socketService.socket.off('mensaje-privado');
    super.dispose();
  }
}
