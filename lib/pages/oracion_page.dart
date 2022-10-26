import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gravini/helpers/helpers.dart';

class OracionPage extends StatefulWidget {
  OracionPage({Key? key}) : super(key: key);

  @override
  State<OracionPage> createState() => _OracionPageState();
}

class _OracionPageState extends State<OracionPage> {
  @override
  Widget build(BuildContext context) {
    final lyrics = getOracion();
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 200),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
                TextStyle estilo = TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                );
                if (index == 4) {
                  estilo = TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blueGrey,
                  );
                  return Container(
                    margin: EdgeInsets.all(30),
                    alignment: Alignment.center,
                    child: Text(lyrics[index], style: estilo),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(left: 30, right: 20),
                    child: Text(lyrics[index], style: estilo),
                  );
                }
              }, childCount: lyrics.length),
            )
          ],
        ),
      ),
    );
  }
}

class _body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lyrics = getOracion();
    return Container(
        child: ListView(
      scrollDirection: Axis.vertical,
      children: lyrics
          .map((line) => Text(
                line,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ))
          .toList(),
    ));
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/girasoles.jpg')),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0XFF2E5596),
                Color(0XFF16304E),
              ],
            ),
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "Meditación sobre la oración",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 3.5,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 80,
              backgroundImage: AssetImage('assets/pAl.jpg'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
