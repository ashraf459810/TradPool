import 'package:flutter/material.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';


import '../../../../Widgets/category_drop.dart';

Widget inputDrop(
    {double width,
    Function value,
    String hint,
    String chosenvalue,
    List<dynamic> list}) {
  return container(
      hight: h(50),
      width: width ?? w(287),
      borderRadius: 5,
      bordercolor: AppColor.grey,
      child: CategoryDropDown(
          chosenvalue: chosenvalue,
          getindex: (val) {},
          hint: "   "+   hint,
          list: list,
          onchanged: value));
}
