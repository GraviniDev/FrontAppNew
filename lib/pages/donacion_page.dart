import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DonacionPage extends StatefulWidget {
  DonacionPage({Key? key}) : super(key: key);

  @override
  State<DonacionPage> createState() => _DonacionPageState();
}

class _DonacionPageState extends State<DonacionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black87),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(children: [
          SizedBox(
            height: 90,
          ),
          Center(
              child: FaIcon(
            FontAwesomeIcons.circleDollarToSlot,
            size: 120,
            color: Colors.yellow,
          )),
          SizedBox(
            height: 90,
          ),
          Center(
            child: Text(
              "Donación",
              style: TextStyle(fontSize: 40, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Center(
            child: Text(
              "Cuenta BBVA",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Graduados de Villa de los niños, México, A.C",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "N° de cuenta 0182224588",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Clabe 01218000182224588",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          )
        ]));
  }
}
