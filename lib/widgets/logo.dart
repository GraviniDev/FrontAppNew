import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;
  final double width;
  final double radio;
  final double top;
  const Logo(
      {Key? key,
      required this.titulo,
      this.width = 400,
      required this.radio,
      required this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(top: top),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: const Color(0xffF2F2F2),
            radius: radio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset('assets/logo.png'),
            ),
            //     backgroundImage: AssetImage('assets/logo.png'),
          ),
          // Image(image: AssetImage('assets/logo.png')),
          const SizedBox(
            height: 20,
          ),
          Text(titulo, style: const TextStyle(fontSize: 30, color: Colors.grey))
        ],
      ),
    );
  }
}
