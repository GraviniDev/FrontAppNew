import 'package:flutter/material.dart';
import 'package:gravini/providers/mostrarMenuFlotante.dart';
import 'package:gravini/widgets/boton_gordo.dart';
import 'package:gravini/widgets/headers.dart';
import 'package:provider/provider.dart';

class RiconPage extends StatefulWidget {
  const RiconPage({Key? key}) : super(key: key);

  @override
  State<RiconPage> createState() => _RiconPageState();
}

class _RiconPageState extends State<RiconPage> {
  @override
  Widget build(BuildContext context) {
    final widthPantalla = MediaQuery.of(context).size.width;
    // final int menuSelect = Provider.of<statusMenu>(context).itemSelecionad;

    return ChangeNotifierProvider(
      create: (_) {
        MostrarMenuModel();
      },
      child: Scaffold(
        body: Stack(children: [
          const _RinconEspiritual(),
          /*Opcion1   Column(
            children: [
              IconHeader(),
              MenuFlotante(),
            ], )*/
          //Opcion2
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

class _publicaciones extends StatefulWidget {
  const _publicaciones({Key? key}) : super(key: key);

  @override
  State<_publicaciones> createState() => __publicacionesState();
}

class __publicacionesState extends State<_publicaciones> {
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
        ],
      ),
    );
  }
}

class _MenuLocation extends StatelessWidget {
  const _MenuLocation({
    Key? key,
    required this.widthPantalla,
  }) : super(key: key);

  final double widthPantalla;

  @override
  Widget build(BuildContext context) {
    final mostrar = Provider.of<MostrarMenuModel>(context).mostrarget;
    return Positioned(
      bottom: 15,
      child: SizedBox(
        width: widthPantalla,
        child: const Align(child: Text("eeeeeeeeeeee ")),
      ),
    );
  }
}
