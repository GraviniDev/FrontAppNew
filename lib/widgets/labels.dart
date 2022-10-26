import 'package:flutter/material.dart';
import 'package:gravini/models/datos_registro.dart';
import 'package:gravini/providers/registro_form_provider.dart';
import 'package:provider/provider.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String titulo;
  final String subTitulo;
  const Labels(
      {Key? key,
      required this.ruta,
      required this.titulo,
      required this.subTitulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Text(
            titulo,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              final datosRegistro =
                  Provider.of<RegistroFormProvider>(context, listen: false);
              final newDatos = DatosRegistro();
              datosRegistro.datosSet(newDatos);
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(
              subTitulo,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
