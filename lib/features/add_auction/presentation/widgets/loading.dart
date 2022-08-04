import 'package:flutter/material.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: w(80),
        height: h(20),
        child: LinearProgressIndicator(
          color: AppColor.blue,
          backgroundColor: Colors.white,
        ));
  }
}
