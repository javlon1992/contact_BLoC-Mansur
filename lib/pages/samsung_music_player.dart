import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];

  int index = 0;

  Color bottomColor = Colors.red;
  Color topColor = Colors.yellow;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [

          AnimatedContainer(
            duration: const Duration(seconds: 4),
            onEnd: () {
              setState(() {
                index = index + 1;
                print(index);
                bottomColor = colorList[index % colorList.length];
                topColor = colorList[(index + 1) % colorList.length];
              });
            },
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, colors: [bottomColor, topColor]),
            ),
          ),
          Positioned.fill(
              child: IconButton(
                alignment: Alignment.bottomCenter,
                onPressed: () {
                  setState(() {
                    bottomColor = Colors.white;
                  });
                },
                icon: const Icon(Icons.play_circle_filled_outlined, size: 50),
              )),
          Image.asset("asset/image/dol.png",
            alignment: Alignment.bottomLeft,),
          Image.asset("asset/image/dol.png",
            alignment: Alignment.topRight,),

        ],
      ),
    );
  }
}