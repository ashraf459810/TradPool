import 'package:flutter/material.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/text.dart';

Widget confirmButton({String hint, Color color, double width}) {
  return container(
      hight: h(50),
      width: width ?? w(287),
      borderRadius: 5,
      color: color ?? AppColor.blue,
      child: Center(
          child: text(
              text: hint, textAlign: TextAlign.center, color: Colors.white)));
}
