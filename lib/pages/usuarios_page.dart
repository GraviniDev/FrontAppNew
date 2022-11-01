import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gravini/models/usuario.dart';
import 'package:gravini/search/search_delegate.dart';
import 'package:gravini/services/chat_service.dart';
import 'package:gravini/services/socket_service.dart';
import 'package:gravini/services/usuarios_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../services/auth_service.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuariosService = UsuariosService();

  List<Usuario> dbUsuario = [];

  @override
  void initState() {
    super.initState();
    _loadConnectedUsers();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments ?? 'No data ';
    final authService = Provider.of<AuthService>(context);
    authService.getCurrentUser();
    final usuario = authService.usuario;

    return Scaffold(
        appBar: AppBar(
          title: Text(usuario?.nombre ?? 'Sin Nombre',
              style: const TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black87),
            onPressed: () {
              /*LOGOUT        
                  Navigator.pushReplacementNamed(context, 'login');
                  AuthService.deleteToken(); */
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: UserSearchDelegate()),
                icon: Icon(Icons.search, color: Colors.blue[400]))
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 90,
              child: _listViewUserOnline(context),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                onRefresh: _loadUsers,
                header: WaterDropHeader(
                  complete: Icon(Icons.check, color: Colors.blue[400]),
                  waterDropColor: Colors.blue.withOpacity(0.4),
                ),
                child: _listViewUserChat(),
              ),
            ),
          ],
        ));
  }

  ListView _listViewUserChat() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _userListTile(dbUsuario[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: dbUsuario.length);
  }

  ListView _listViewUserOnline(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => Row(
              children: [
                _userOnlineContainer(authService.usersConnected[i], context),
              ],
            ),
        itemCount: authService.usersConnected.length);
  }

  ListTile _userListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre!),
      subtitle: Text(
          'Año ingreso ${usuario.anioIngreso!.toString()}- ${usuario.campusVilla!}'),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        backgroundImage: usuario.imagenPerfil == null
            ? const AssetImage('assets/images.png') as ImageProvider
            : NetworkImage(usuario.imagenPerfil!),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: (usuario.conectado == null ? false : usuario.conectado!)
                ? Colors.green[300]
                : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'mensaje');
      },
    );
  }

  _userOnlineContainer(Usuario usuario, BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.center,
      width: 100,
      child: Column(children: [
        TextButton(
            onPressed: () {
              final chatService =
                  Provider.of<ChatService>(context, listen: false);
              chatService.usuarioPara = usuario;
              Navigator.pushNamed(context, 'mensaje');
            },
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(223, 110, 137, 158),
                  backgroundImage: usuario.imagenPerfil == null
                      ? const AssetImage('assets/images.png') as ImageProvider
                      : NetworkImage(usuario.imagenPerfil!),
                  maxRadius: 20,
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color:
                          usuario.conectado! ? Colors.green[300] : Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ],
            )),
        Text(
          usuario.nombre!.length > 15
              ? usuario.nombre!.substring(0, 15)
              : usuario.nombre!,
          style: const TextStyle(fontSize: 8),
        ),
      ]),
    );
  }

  _loadUsers() async {
    dbUsuario = await _addStatus(await usuariosService.getUsersChat());

    setState(() {});
    _refreshController.refreshCompleted();
  }

  List<Usuario> _addStatus(List<Usuario> dbUsers) {
    final authService = Provider.of<AuthService>(context, listen: false);
    List<Usuario> listUsersAll = [];
    for (var item in dbUsers) {
      if (authService.usersConnected
          .where((element) => element.uid == item.uid)
          .toList()
          .isNotEmpty) {
        item.conectado = true;
      } else {
        item.conectado = false;
      }

      listUsersAll.insert(0, item);
    }

    return listUsersAll;
  }

//Metodo para socket usuarios-conectados
  _loadConnectedUsers() async {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.connect();
    socketService.socket.on('usuarios-conectados', _listenSocket);
  }

  void _listenSocket(dynamic data) {
    List<Usuario> usersPrevious = [];
    data.forEach((item) {
      String? nombre = item['nombre'];
      String? apellidoPaterno = item['apellidoPaterno'];
      String? apellidoMaterno = item['apellidoMaterno'];
      String? curp = item['curp'];
      String? numeroCelular = item['numeroCelular'];
      String? estadoResidencia = item['estadoResidencia'];
      String? imagenPerfil = item['img'];
      DateTime? fechaNacimiento = DateTime.parse(item['fechaNacimiento']);
      bool? esEgresado = item['esEgresado'];
      int? anioIngreso = item['anioIngreso'];
      String? campusVilla = item['campusVilla'];
      String? correo = item['correo'];
      int? rol = item['rol'];
      bool? estado = item['estado'];
      String? uid = item['uid'];

      // ignore: unnecessary_new
      Usuario userConnected = new Usuario(
          nombre: nombre,
          apellidoPaterno: apellidoPaterno,
          apellidoMaterno: apellidoMaterno,
          curp: curp,
          numeroCelular: numeroCelular,
          estadoResidencia: estadoResidencia,
          imagenPerfil: imagenPerfil,
          fechaNacimiento: fechaNacimiento,
          esEgresado: esEgresado,
          anioIngreso: anioIngreso,
          campusVilla: campusVilla,
          correo: correo,
          rol: rol,
          estado: estado,
          uid: uid,
          conectado: true);

      usersPrevious.insert(0, userConnected);
    });
    _loadUsers();
    setState(() {
      final authService = Provider.of<AuthService>(context, listen: false);
      authService.getUserConnected(usersPrevious);
    });
    //below is the solution
  }
}
