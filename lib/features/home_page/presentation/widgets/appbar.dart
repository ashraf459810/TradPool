import 'package:flutter/material.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Widgets/container.dart';

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({Key key}) : super(key: key);

  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(h(100)),
        child: Padding(
          padding: EdgeInsets.only(top: h(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              container(
                hight: h(36),
                width: w(36),
                color: Colors.white,
                child: const Center(
                    child: Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 30,
                )),
              ),
              Image.asset(
                "assets/images/tradpool.png",
                height: h(30),
                width: w(176),
                fit: BoxFit.contain,
              ),
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Center(
                      child: Image.asset(
                    "assets/images/exampleIcon.png",
                    height: h(50),
                    width: w(50),
                    fit: BoxFit.contain,
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
