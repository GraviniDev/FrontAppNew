import 'package:flutter/material.dart';

class statusMenu with ChangeNotifier {
  int _itemSeleccionado = 1;
  int get itemSelecionad => _itemSeleccionado;

  set itemSelecionadoset(int index) {
    _itemSeleccionado = index;
    notifyListeners();
  }
}
