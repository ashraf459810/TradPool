import 'package:flutter/material.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/core/consts.dart';

class ThreeDash extends StatelessWidget {
  final int selected;
  const ThreeDash({Key key, this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: h(10),
            child: Center(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: (MediaQuery.of(context).size.width / 3.5)),
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => selected >= index
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(5)),
                        child: Center(child: dash(true)),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(5)),
                        child: Center(child: dash(false)),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dash(bool selected) {
    return Center(
      child: container(
          color: selected ? AppColor.blue : Colors.teal[100],
          hight: h(3),
          width: w(40)),
    );
  }
}
