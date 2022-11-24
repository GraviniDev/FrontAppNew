import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gravini/models/oraciones.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../services/oraciones_service.dart';

class SpirtualDetailPage extends StatefulWidget {
  @override
  State<SpirtualDetailPage> createState() => _SpirtualDetailStatePage();
}

class _SpirtualDetailStatePage extends State<SpirtualDetailPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Oraciones> dbPrayer = [];
  @override
  void initState() {
    super.initState();
    _loadPrayer();
  }

  _loadPrayer() async {
    final oracionesService =
        Provider.of<OracionesServices>(context, listen: false);

    dbPrayer = await oracionesService.getOraciones();
    dbPrayer.sort((a, b) => a.id!.compareTo(b.id!));
    setState(() {});
    _refreshController.refreshCompleted();
  }

  Widget build(BuildContext context) {
    final oracionesService =
        Provider.of<OracionesServices>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text(oracionesService.getTitulo.toString(),
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
        body: Container(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) => _playerListTile(dbPrayer[i], context),
                separatorBuilder: (_, i) => const Divider(),
                itemCount: dbPrayer.length)));
  }
}

ListTile _playerListTile(Oraciones player, BuildContext context) {
  return ListTile(
    title: Text(player.titulo!,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
    subtitle: Text(player.subtitulo!.toString()),
    leading: CircleAvatar(
      radius: 30,
      backgroundColor: Colors.blue[100],
      backgroundImage: player.imagen == null
          ? const AssetImage('assets/images.png') as ImageProvider
          : NetworkImage(player.imagen!),
    ),
    onTap: () {
      final oracionesService =
          Provider.of<OracionesServices>(context, listen: false);
      oracionesService.setPrayerDetail = player;
      Navigator.pushNamed(context, 'PlayerDetailPage');
    },
  );
}
