import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonRincon extends StatelessWidget {
  final String imagen;
  final String titulo;
  final String subtitulo;
  final void Function() onPressr;
  const BotonRincon(
      {Key? key,
      required this.imagen,
      required this.titulo,
      required this.subtitulo,
      required this.onPressr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressr,
      // () {
      // Navigator.pushReplacementNamed(context, 'spiritualPage');
      //},
      child: Stack(
        children: [
          const _BotonGordoBackground(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 140,
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 80,
                  backgroundImage: AssetImage(imagen),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        titulo,
                        style: const TextStyle(
                            leadingDistribution:
                                TextLeadingDistribution.proportional,
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        subtitulo,
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _BotonGordoBackground extends StatelessWidget {
  const _BotonGordoBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(4, 6),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned(
                  right: -20,
                  top: -20,
                  child: FaIcon(
                    FontAwesomeIcons.handsPraying,
                    size: 150,
                    color: Colors.white.withOpacity(0),
                  ))
            ],
          ),
        ));
  }
}
