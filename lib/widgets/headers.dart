import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconHeader extends StatelessWidget {
  const IconHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _IconHeaderBackground(),
        Padding(
          padding: const EdgeInsets.only(top: 30, right: 0, left: 10),
          child: Column(
            children: [
              Row(
                children: const [
                  _avatarLogo(),
                  Expanded(
                    child: _IconosSecudarios(),
                  ),
                  _Menu(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconosSecudarios extends StatelessWidget {
  const _IconosSecudarios({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /*  IconButton(
          icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
          iconSize: 25,
          color: const Color.fromARGB(238, 185, 183, 183),
          onPressed: () {},
        ), */
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.circleDollarToSlot),
          iconSize: 25,
          color: const Color.fromARGB(238, 185, 183, 183),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'donacion');
          },
        ),
        // IconButton(
        //   icon: const FaIcon(FontAwesomeIcons.solidBell),
        //   iconSize: 25,
        //   color: const Color.fromARGB(238, 185, 183, 183),
        //   onPressed: () {},
        // ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.facebookMessenger),
          iconSize: 25,
          color: const Color.fromARGB(238, 185, 183, 183),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'usuarios');
          },
        ),
      ],
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const FaIcon(FontAwesomeIcons.bars),
      iconSize: 20,
      focusColor: ThemeData.light().primaryColor,
      color: const Color.fromARGB(238, 185, 183, 183),
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'menu');
      },
    );
  }
}

class _avatarLogo extends StatelessWidget {
  const _avatarLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Image.asset('assets/logo.png'),
        ),
        //     backgroundImage: AssetImage('assets/logo.png'),
      ),
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  const _IconHeaderBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.white,
    );
  }
}
