import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:html/dom.dart' as dom;
import '../search/search_delegate.dart';
import '../services/oraciones_service.dart';

class SpirtualDetailPage extends StatefulWidget {
  SpirtualDetailPage({Key? key}) : super(key: key);

  @override
  State<SpirtualDetailPage> createState() => _SpirtualDetailStatePage();
}

class _SpirtualDetailStatePage extends State<SpirtualDetailPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    final oracionesService =
        Provider.of<OracionesServices>(context, listen: false);

    oracionesService.getOraciones();
    return Scaffold(
        appBar: AppBar(
          title: Text("", style: const TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black87),
            onPressed: () {
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
        body: Container(
            /*     child: SingleChildScrollView(
            child: Html(
              data: """
                <div>Follow<a class='sup'><sup>pl</sup></a> 
                  Below hr
                    <b>Bold</b>
                <h1>what was sent down to you from your Lord</h1>, 
                and do not follow other guardians apart from Him. Little do 
                <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
                """,
            ),
          ), */

            // child: ListView.separated(
            //     physics: const BouncingScrollPhysics(),
            //     itemBuilder: (_, i) => _userListTile(dbUsuario[i]),
            //     separatorBuilder: (_, i) => const Divider(),
            //     itemCount: dbUsuario.length)
            ));
  }
}

// ListTile _userListTile(Usuario usuario) {
//   return ListTile(
//     title: Text(usuario.nombre!),
//     subtitle: Text(
//         'Año ingreso ${usuario.anioIngreso!.toString()}- ${usuario.campusVilla!}'),
//     leading: CircleAvatar(
//       backgroundColor: Colors.blue[100],
//       backgroundImage: usuario.imagenPerfil == null
//           ? const AssetImage('assets/images.png') as ImageProvider
//           : NetworkImage(usuario.imagenPerfil!),
//     ),
//     trailing: Container(
//       width: 10,
//       height: 10,
//       decoration: BoxDecoration(
//           color: (usuario.conectado == null ? false : usuario.conectado!)
//               ? Colors.green[300]
//               : Colors.red,
//           borderRadius: BorderRadius.circular(100)),
//     ),
//     onTap: () {
//       final chatService = Provider.of<ChatService>(context, listen: false);
//       chatService.usuarioPara = usuario;
//       Navigator.pushNamed(context, 'mensaje');
//     },
//   );
//}
