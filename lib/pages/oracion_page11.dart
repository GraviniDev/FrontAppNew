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
    return //Scaffold(
        /*     body: Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      alignment: Alignment.center,
      child: Column(
        children: [
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(expandedHeight: 200),
                pinned: true,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((_, index) => ListTile(
                        title: Text("Index:$index"),
                      )))
            ],
          )
          /*    Container(
            
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 80,
                    backgroundImage: AssetImage('assets/pAl.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'MEDITACIÓN SOBRE LA ORACIÓN',
                  style: const TextStyle(
                      leadingDistribution: TextLeadingDistribution.proportional,
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '(P. Aloysius Schwartz)',
                  style: const TextStyle(
                      leadingDistribution: TextLeadingDistribution.proportional,
                      color: Colors.blueGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ), */
          ,
          const SizedBox(
            height: 20,
          ),
          // Expanded(child: _body())
        ],
      ),
    )
     */
        SafeArea(
            child: Material(
                child: CustomScrollView(slivers: [
      SliverPersistentHeader(
        delegate: MySliverAppBar(expandedHeight: 200),
        pinned: true,
      ),
      SliverPadding(
        padding: EdgeInsets.symmetric(vertical: 20),
        sliver: _body(),
      )
    ])));

    final lyrics = getOracion();
    final index = getOracion().length;
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  MySliverAppBar({required this.expandedHeight});
  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
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
              'MEDITACIÓN SOBRE LA ORACIÓN',
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


// child: ListWheelScrollView(
//       itemExtent: 80,
//       diameterRatio: 5,
//       physics: BouncingScrollPhysics(),
//       children: lyrics
//           .map((line) => Text(
//                 line,
//                 style: TextStyle(fontSize: 20, color: Colors.blueGrey),
//               ))
//           .toList(),
//     )
