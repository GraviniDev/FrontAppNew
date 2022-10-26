import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonBolsa extends StatelessWidget {
  final String puesto;
  final String empresa;
  final String lugar;
  final String sueldo;
  final String tiempo;
  const BotonBolsa(
      {Key? key,
      required this.puesto,
      required this.empresa,
      required this.lugar,
      required this.sueldo,
      required this.tiempo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _BotonGordoBackground(),
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30, left: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  puesto,
                  style: const TextStyle(
                      leadingDistribution: TextLeadingDistribution.proportional,
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  empresa,
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: const FaIcon(
                        FontAwesomeIcons.mapLocation,
                        size: 15,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      lugar,
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: const FaIcon(
                        FontAwesomeIcons.moneyBill,
                        size: 15,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      sueldo,
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: const FaIcon(
                        FontAwesomeIcons.briefcase,
                        size: 15,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      tiempo,
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 40,
        ),
      ],
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
        height: 180,
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
          /*   gradient: LinearGradient(colors: <Color>[
              Color(0xff6989F),
              Color.fromARGB(255, 29, 59, 141)
            ]) */
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
