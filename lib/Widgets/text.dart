import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/Core/navigate_service.dart';

import '../App/app_localizations.dart';
import '../injection_container.dart';

Widget text(
    {String text,
    Color color,
    double fontsize,
    FontWeight fontWeight,
    String fontfamily,
    TextDecoration textDecoration,
    TextAlign textAlign}) {
  return Text(
  AppLocalizations.of(sl<NavigationService>().navigatorKey.currentContext).translate(text)??text??"",
    // overflow: TextOverflow.ellipsis,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
        decoration: textDecoration ?? TextDecoration.none,
        fontFamily: fontfamily ?? "font",
        color: color,
        fontSize: fontsize ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.normal),
  );
}
