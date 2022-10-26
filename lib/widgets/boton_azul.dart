import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String texto;
  final void Function() onPressr;

  const BotonAzul({Key? key, required this.texto, required this.onPressr})
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
            primary: Colors.blue,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          onPressed: onPressr,
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: Center(
                child: Text(
              texto,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            )),
          )),
    );
  }
}
