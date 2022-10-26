import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/statusMenuFlotante.dart';

class MenuFloatante extends StatelessWidget {
  final bool mostrar;
  final List<MenuButton> listMenu;
  const MenuFloatante({Key? key, required this.mostrar, required this.listMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuButton> items = listMenu;

    /*   return 
    ChangeNotifierProvider(
      create: (_) => statusMenu(),
      child: */
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: (mostrar) ? 1 : 0,
      child: Container(
        width: 300,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: -5)
            ]),
        child: _MenuItems(menuItems: items),
      ),
      // ),
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
    final itemSelecionado = Provider.of<statusMenu>(context).itemSelecionad;
    bool selected = false;
    return GestureDetector(
      onTap: () {
        Provider.of<statusMenu>(context, listen: false).itemSelecionadoset =
            index;

        selected = !selected;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        width: selected ? 200.0 : 100.0,
        height: selected ? 100.0 : 200.0,
        alignment: selected ? Alignment.center : AlignmentDirectional.topCenter,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
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
      ),
    );
  }
}
