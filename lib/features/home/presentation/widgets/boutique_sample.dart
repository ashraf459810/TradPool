import 'package:flutter/material.dart';

import '../../../../App/app.dart';
import '../../../../Widgets/container.dart';

class BoutiqueSamle extends StatefulWidget {
  final String image;
  const BoutiqueSamle({Key key, this.image}) : super(key: key);

  @override
  State<BoutiqueSamle> createState() => _BoutiqueSamleState();
}

class _BoutiqueSamleState extends State<BoutiqueSamle> {
  @override
  Widget build(BuildContext context) {
   return  Card(
    child: container(

        hight: h(250),
        width: w(160),
        child: container(
            // color: Colors.green,
        
            child: Center(
          child: widget.image != null
              ? Image.network(
                 widget. image,
                  fit: BoxFit.cover,
                  height: h(170),
                )
              : Image.asset(
                  "assets/images/sample.png",
                  fit: BoxFit.fill,
                  height: h(150),
                ),
        ))));
  }
}