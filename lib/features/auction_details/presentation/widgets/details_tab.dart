import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/core/consts.dart';

Widget detailsTap(bool isone, String firsticon, String secondicon, String title,
    String value, String title2, String value2) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: w(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(firsticon),
            SizedBox(
              width: w(10),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: text(
                      text: title,
                      fontsize: 12.sp,
                      
                      color: AppColor.hintcolor,
                      textAlign: TextAlign.start),
                ),
                SizedBox(
                  height: h(3),
                ),
                SizedBox(
                  width: 50.w,
                  child: SizedBox(
                    child: text(
                        text: value,
                        fontsize: 12.sp,
                        color: Colors.black,
                        textAlign: TextAlign.start),
                  ),
                ),
              ],
            ),
          ],
        ),
        isone
            ? Row(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      text(
                          text: title2,
                          fontsize: 12.sp,
                          color: AppColor.hintcolor),
                      SizedBox(
                        height: h(3),
                      ),
                      text(
                        text: value2,
                        fontsize: 14.sp,
                        color: Colors.black,
                      ),
                      title2.contains("Direct buy price")
                          ? container(
                              color: Colors.red,
                              hight: h(1),
                              width: w(60),
                              child: text(
                                  text: "",
                                  color: Colors.white,
                                  fontsize: 8,
                                  textAlign: TextAlign.center))
                          : const SizedBox()
                    ],
                  ),
                  SizedBox(
                    width: w(5),
                  ),
                  SvgPicture.asset(secondicon),
                ],
              )
            : const SizedBox(),
      ],
    ),
  );
}
