import 'package:flutter/material.dart';
import 'package:gravini/services/chat_service.dart';
import 'package:gravini/services/usuarios_service.dart';
import 'package:provider/provider.dart';

import '../models/usuario.dart';

class UserSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Sin resultados');
  }

  Widget _emptyContainer() {
    return Container(
        child: Center(
      child: Icon(
        Icons.error_outline_rounded,
        color: Colors.black38,
        size: 100,
      ),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final usuariosProvider = UsuariosService();

    return FutureBuilder(
        future: usuariosProvider.searchUsers(query),
        builder: (_, AsyncSnapshot<List<Usuario>> snapshot) {
          if (!snapshot.hasData) return _emptyContainer();
          final usuario = snapshot.data!;
          return ListView.builder(
            itemBuilder: ((context, int index) =>
                _usuarioItem(user: usuario[index])),
            itemCount: usuario.length,
          );
        });
  }
}

class _usuarioItem extends StatelessWidget {
  final Usuario user;
  const _usuarioItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nombreCompleto =
        '${user.nombre} ${user.apellidoPaterno} ${user.apellidoMaterno}';
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.nombre!.substring(0, 2)),
      ),
      title: Text(nombreCompleto),
      subtitle: Text('Generación ${user.anioIngreso} - ${user.campusVilla} '),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = user;
        Navigator.pushNamed(context, 'mensaje');
      },
    );
  }
}
