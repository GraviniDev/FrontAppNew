import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gravini/providers/mostrarMenuFlotante.dart';
import 'package:gravini/providers/statusMenuFlotante.dart';
import 'package:gravini/services/bolsa_service.dart';
import 'package:gravini/services/oraciones_service.dart';
import 'package:gravini/widgets/boton_bolsa.dart';
import 'package:gravini/widgets/boton_gordo.dart';
import 'package:gravini/widgets/boton_riconEspiritual.dart';
import 'package:gravini/widgets/headers.dart';
import 'package:gravini/widgets/menu_flotante.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final widthPantalla = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) {
        MostrarMenuModel();
      },
      child: Scaffold(
        body: Stack(children: [
          const _body(),
          const IconHeader(),
          _MenuLocation(widthPantalla: widthPantalla)
        ]),
      ),
    );
  }
}

class _RinconEspiritual extends StatefulWidget {
  const _RinconEspiritual({
    Key? key,
  }) : super(key: key);

  @override
  State<_RinconEspiritual> createState() => _RinconEspiritualState();
}

class _RinconEspiritualState extends State<_RinconEspiritual> {
  ScrollController controller = ScrollController();
  double scrollAnterior = 0;
  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset > scrollAnterior) {
        if (controller.offset == 0) {
          Provider.of<MostrarMenuModel>(context, listen: false).mostrarset =
              true;
        }
        Provider.of<MostrarMenuModel>(context, listen: false).mostrarset =
            false;
      } else {
        Provider.of<MostrarMenuModel>(context, listen: false).mostrarset = true;
      }
      scrollAnterior = controller.offset;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: ListView(
        controller: controller,
        children: const [
          SizedBox(
            height: 10,
          ),
          BotonGordo(),
          BotonGordo(),
          BotonGordo(),
          BotonGordo(),
          BotonGordo(),
          BotonGordo(),
          BotonGordo(),
          BotonGordo(),
          BotonGordo(),
        ],
      ),
    );
  }
}

class _body extends StatefulWidget {
  const _body({Key? key}) : super(key: key);

  @override
  State<_body> createState() => __bodyState();
}

class __bodyState extends State<_body> {
  ScrollController controller = ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset > scrollAnterior) {
        if (controller.offset == 0) {
          Provider.of<MostrarMenuModel>(context, listen: false).mostrarset =
              true;
        }
        Provider.of<MostrarMenuModel>(context, listen: false).mostrarset =
            false;
      } else {
        Provider.of<MostrarMenuModel>(context, listen: false).mostrarset = true;
      }
      scrollAnterior = controller.offset;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int menuSelect = Provider.of<statusMenu>(context).itemSelecionad;
    return ChangeNotifierProvider(
      create: (_) => statusMenu(),
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: menuSelect == 0
            ? _listPublicaciones(controller: controller)
            : menuSelect == 1
                ? _listSpiritual(controller: controller)
                : _listJobs(controller: controller),
      ),
    );
  }
}

class _listJobs extends StatefulWidget {
  const _listJobs({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  State<_listJobs> createState() => _listJobsState();
}

class _listJobsState extends State<_listJobs> {
  @override
  Widget build(BuildContext context) {
    final oracionesService = Provider.of<BolsaServices>(context, listen: false);

    oracionesService.getJobs();

    return ListView(
      controller: widget.controller,
      children: const [
        SizedBox(
          height: 30,
        ),
        Center(
            child: Text(
          "Bolsa de trabajo",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 10,
        ),
        BotonBolsa(
            puesto: "Project Manager",
            empresa: "Consultoria INTERAX",
            lugar: "Nuevo León",
            sueldo: "\$19,508-\$25,705",
            tiempo: "Por tiempo indeterminado"),
        BotonBolsa(
            puesto: "Lider de proyecto y capital humano",
            empresa: "Grupo Salaya",
            lugar: "Villahermosa, Tab",
            sueldo: "\$12,000 -\$18,000 al mes",
            tiempo: "Por tiempo completo"),
        BotonBolsa(
            puesto: "Comisionista Libre",
            empresa: "Construyendo equipos Castro S.A de C.V",
            lugar: "Ciudad de México",
            sueldo: "-",
            tiempo: "Por tiempo indeterminado"),
        BotonBolsa(
            puesto: "Project Manager",
            empresa: "Consultoria INTERAX",
            lugar: "Nuevo León",
            sueldo: "\$19,508-\$25,705",
            tiempo: "Por tiempo indeterminado"),
        BotonBolsa(
            puesto: "Project Manager",
            empresa: "Consultoria INTERAX",
            lugar: "Nuevo León",
            sueldo: "\$19,508-\$25,705",
            tiempo: "Por tiempo indeterminado"),
        BotonBolsa(
            puesto: "Project Manager",
            empresa: "Consultoria INTERAX",
            lugar: "Nuevo León",
            sueldo: "\$19,508-\$25,705",
            tiempo: "Por tiempo indeterminado"),
        BotonBolsa(
            puesto: "Project Manager",
            empresa: "Consultoria INTERAX",
            lugar: "Nuevo León",
            sueldo: "\$19,508-\$25,705",
            tiempo: "Por tiempo indeterminado")
      ],
    );
  }
}

class _listPublicaciones extends StatefulWidget {
  const _listPublicaciones({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  State<_listPublicaciones> createState() => _listPublicacionesState();
}

class _listPublicacionesState extends State<_listPublicaciones> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      children: const [
        SizedBox(
          height: 30,
        ),
        Center(
            child: Text(
          "Publicaciones",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _listSpiritual extends StatefulWidget {
  const _listSpiritual({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  State<_listSpiritual> createState() => _listSpiritualState();
}

class _listSpiritualState extends State<_listSpiritual> {
  @override
  Widget build(BuildContext context) {
    final oracionesService =
        Provider.of<OracionesServices>(context, listen: false);
    return ListView(
      controller: widget.controller,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Center(
            child: Text(
          "Rincon espiritual",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
        const SizedBox(
          height: 10,
        ),
        BotonRincon(
          imagen: 'assets/pAl.jpg',
          titulo: 'Meditación sobre la oración',
          subtitulo: '¡Mira lo que dice el Padre Al acerca de ella!',
          onPressr: () {
            Navigator.pushNamed(context, 'oracionPage');
          },
        ),
        BotonRincon(
            imagen: 'assets/meditacion.jpg',
            titulo: 'Meditación Diaria',
            subtitulo:
                'Encontraras las principales oraciones para tu día a día.',
            onPressr: () {
              oracionesService.setTitulo = 'Meditación Diaria';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/oraciones_comunes.jpg',
            titulo: 'Oraciones Comunes',
            subtitulo:
                'Encontraras las principales oraciones para tu día a día.',
            onPressr: () {
              oracionesService.setTitulo = 'Oraciones Comunes';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/jesus.jpg',
            titulo: 'Devoción a Jesús',
            subtitulo:
                'Encontraras las principales oraciones para tu día a día.',
            onPressr: () {
              oracionesService.setTitulo = 'Devoción a Jesús';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/maria.jpg',
            titulo: 'Devoción a María',
            subtitulo:
                'Encontraras las principales oraciones para tu día a día.',
            onPressr: () {
              oracionesService.setTitulo = 'Devoción a María';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/santos.jpg',
            titulo: 'Devoción a los Santos',
            subtitulo:
                'Encontraras las principales oraciones para tu día a día.',
            onPressr: () {
              oracionesService.setTitulo = 'Devoción a los Santos';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/viacrucis.jpg',
            titulo: 'El Camino de la Cruz (El Vía Crucis por el Padre Al)',
            subtitulo:
                'Encontraras las principales oraciones para tu día a día.',
            onPressr: () {
              oracionesService.setTitulo =
                  'El Camino de la Cruz (El Vía Crucis por el Padre Al)';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/confecion.jpg',
            titulo: 'La Confesión',
            subtitulo: 'La Confesión',
            onPressr: () {
              oracionesService.setTitulo = 'Meditación Diaria';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/oraciones_comunes.jpg',
            titulo: 'Otras Oraciones',
            subtitulo:
                'Encontraras las principales oraciones para tu día a día.',
            onPressr: () {
              oracionesService.setTitulo = 'Otras Oraciones';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/catecismo.jpg',
            titulo: 'Catecismo Básico',
            subtitulo:
                'Encontraras las principales oraciones para tu día a día.',
            onPressr: () {
              oracionesService.setTitulo = 'Catecismo Básico';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/pAl2.jpg',
            titulo: 'CANTOS',
            subtitulo: 'El que canta ora dos veces.',
            onPressr: () {
              oracionesService.setTitulo = 'CANTOS';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
        BotonRincon(
            imagen: 'assets/img1.jpg',
            titulo: 'REFLEXIONES',
            subtitulo:
                'Tomate unos minutos para reflexionar de tu vida espiritual',
            onPressr: () {
              oracionesService.setTitulo = 'REFLEXIONES';
              Navigator.pushNamed(context, 'spiritualPage');
            }),
      ],
    );
  }
}

class _MenuLocation extends StatefulWidget {
  const _MenuLocation({
    Key? key,
    required this.widthPantalla,
  }) : super(key: key);

  final double widthPantalla;

  @override
  State<_MenuLocation> createState() => _MenuLocationState();
}

class _MenuLocationState extends State<_MenuLocation> {
  @override
  Widget build(BuildContext context) {
    final mostrar = Provider.of<MostrarMenuModel>(context).mostrarget;
    return Positioned(
      bottom: 15,
      child: SizedBox(
        width: widget.widthPantalla,
        child: Align(
            child: MenuFloatante(
          mostrar: mostrar,
          listMenu: [
            MenuButton(
              texto: const Text(
                "Publicaciones",
                style: TextStyle(fontSize: 10),
              ),
              onPressed: () {
                // setState(() {});
                Navigator.pushReplacementNamed(context, 'home');
              },
              icon: FontAwesomeIcons.rectangleList,
            ),
            MenuButton(
              texto: const Text(
                "Rincon Espiritual",
                style: TextStyle(fontSize: 10),
              ),
              onPressed: () {
                // setState(() {});
                Navigator.pushReplacementNamed(context, 'home');
                //Navigator.pushReplacementNamed(context, 'rincon');
              },
              icon: FontAwesomeIcons.handsPraying,
            ),
            MenuButton(
                texto: const Text(
                  "Bolsa de trabajo",
                  style: TextStyle(fontSize: 10),
                ),
                onPressed: () {
                  setState(() {});
                },
                icon: FontAwesomeIcons.briefcase),
          ],
        )),
      ),
    );
  }
}
