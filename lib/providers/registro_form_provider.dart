import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravini/models/datos_registro.dart';

class RegistroFormProvider with ChangeNotifier {
  DatosRegistro? _datos;

  bool? get existeUsuario => _datos != null ? true : false;

  DatosRegistro? get datosget => _datos;

  void datosSet(DatosRegistro? newDatos) {
    _datos = newDatos;

    notifyListeners();
  }
}
