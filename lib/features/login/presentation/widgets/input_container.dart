import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';

import 'package:tradpool/Widgets/text_form.dart';

Widget inputContainer(
    {TextEditingController controller,
    Key key,
    double hight,
    Function value,
    String hint,
    EdgeInsetsGeometry edgeInsetsGeometry,
    String validation,
    bool isscure,
    Widget widget,
    int maxlines,
    double width,
    double textFormWidth}) {
  return container(
      hight: hight ?? h(50),
      width: width ?? w(287),
      borderRadius: 5,
      bordercolor: AppColor.grey,
      child: Center(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: textFormWidth ?? w(260),
              child: textform(
                key: key,
                maxlines: maxlines ?? 1,
                controller: controller,
                padding: edgeInsetsGeometry ?? EdgeInsets.all(h(10)),
                hintsize: 12.sp,
                hint: hint,
                issecure: isscure ?? false,
                validation: validation ?? "name",
                hintColor: AppColor.hintcolor,
                function: (val) {
                  value(val);
                },
              ),
            ),
            widget ?? const SizedBox()
          ],
        ),
      ));
}
