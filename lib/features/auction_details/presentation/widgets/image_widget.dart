import 'package:flutter/material.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Widgets/container.dart';

import '../../../../Core/consts.dart';

class ImageZoom extends StatefulWidget {
  final String image;
  const ImageZoom({Key key, this.image}) : super(key: key);

  @override
  State<ImageZoom> createState() => _ImageZoomState();
}

class _ImageZoomState extends State<ImageZoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.black,

      body: Column(
        children: [
          SizedBox(height: h(50),),
          Row(children: [
            SizedBox(width: w(40),),
            GestureDetector(onTap: (){
              Navigator.of(context).pop();
            },
              child: Icon(Icons.close,color:AppColor.blue,))
          ],),
          container(hight: h(700),width: w(350),child: Image.network(widget.image,fit: BoxFit.contain,)),
        ],
      ),
    );
  }
}