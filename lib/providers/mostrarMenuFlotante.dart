import 'package:flutter/material.dart';

class MostrarMenuModel with ChangeNotifier {
  bool _mostrar = true;
  bool get mostrarget => _mostrar;
  set mostrarset(bool valor) {
    _mostrar = valor;
    notifyListeners();
  }
}
