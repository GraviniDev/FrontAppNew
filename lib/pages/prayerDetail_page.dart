import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/oraciones_service.dart';

class PlayerDetailPage extends StatefulWidget {
  PlayerDetailPage({Key? key}) : super(key: key);

  @override
  State<PlayerDetailPage> createState() => _PlayerDetailPageState();
}

class _PlayerDetailPageState extends State<PlayerDetailPage> {
  @override
  Widget build(BuildContext context) {
    final oracionesService =
        Provider.of<OracionesServices>(context, listen: false);

    final detail = oracionesService.getPrayerDetail;
    String? titulo = detail?.titulo;
    String? img = detail?.imagen;
    return Scaffold(
        appBar: AppBar(
          title: Text(titulo!, style: const TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black87),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'spiritualPage');
            },
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue[100],
                  backgroundImage: img == null
                      ? const AssetImage('assets/images.png') as ImageProvider
                      : NetworkImage(img),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                        leadingDistribution:
                            TextLeadingDistribution.proportional,
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Html(
                  data: detail?.detalle.toString(),
                ),
              ],
            ),
          ),
        ));
  }
}
