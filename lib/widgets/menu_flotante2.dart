import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MenuFloatante2 extends StatelessWidget {
  final bool mostrar;
  const MenuFloatante2({Key? key, required this.mostrar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuButton> items = [
      MenuButton(
        texto: const Text(
          "Publicaciones",
          style: TextStyle(fontSize: 10),
        ),
        onPressed: () {
          print('Nombres ');
        },
        icon: FontAwesomeIcons.solidImage,
      ),
      MenuButton(
        texto: const Text(
          "Rincon Espiritual",
          style: TextStyle(fontSize: 10),
        ),
        onPressed: () {
          print('Nombres ');
        },
        icon: FontAwesomeIcons.handsPraying,
      ),
      MenuButton(
          texto: const Text(
            "Bolsa de trabajo",
            style: TextStyle(fontSize: 10),
          ),
          onPressed: () {
            print('Nombres ');
          },
          icon: FontAwesomeIcons.briefcase),
    ];

    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: (mostrar) ? 1 : 0,
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, blurRadius: 10, spreadRadius: -5)
              ]),
          child: _MenuItems(menuItems: items),
        ),
      ),
    );
  }
}

class MenuButton {
  final Function onPressed;
  final IconData icon;
  final Text texto;

  MenuButton(
      {required this.texto, required this.onPressed, required this.icon});
}

class _MenuItems extends StatelessWidget {
  final List<MenuButton> menuItems;
  const _MenuItems({Key? key, required this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          List.generate(menuItems.length, (i) => _MenuButton(i, menuItems[i])),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final int index;
  final MenuButton item;
  const _MenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final itemSelecionado = Provider.of<_MenuModel>(context).itemSelecionad;

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSelecionado = index;

        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Icon(
              item.icon,
              size: (itemSelecionado == index) ? 35 : 25,
              color: (itemSelecionado == index)
                  ? ThemeData.light().primaryColor
                  : Colors.blueGrey,
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: (itemSelecionado == index) ? 0 : 1,
                child: item.texto),
          ],
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  int get itemSelecionad => _itemSeleccionado;

  set itemSelecionado(int index) {
    _itemSeleccionado = index;
    notifyListeners();
  }
}
