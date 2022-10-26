import 'package:flutter/material.dart';

class BotonAzulShort extends StatelessWidget {
  final String texto;
  final void Function() onPressr;
  final Color? colorBtn;

  const BotonAzulShort(
      {Key? key,
      required this.texto,
      required this.onPressr,
      this.colorBtn = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // Foreground color
            onPrimary: Colors.white,
            elevation: 2,
            shape: const StadiumBorder(),
            // Background color
            primary: colorBtn,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          onPressed: onPressr,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .25,
            height: 40,
            child: Center(
                child: Text(
              texto,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )),
          )),
    );
  }
}
