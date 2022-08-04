import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradpool/features/notifications/presentation/bloc/notifications_bloc.dart';

import '../App/app.dart';
import '../Core/consts.dart';
import '../features/notifications/presentation/pages/notifications.dart';
import '../features/search/presentation/pages/search.dart';
import '../injection_container.dart';
import 'container.dart';
import 'nav.dart';

class DefaultAppBar extends StatefulWidget {

  const DefaultAppBar({Key key,}) : super(key: key);


  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar>
    with SingleTickerProviderStateMixin {
     final  notificationsBloc= sl<NotificationsBloc>() ;
  AnimationController _animationController;
  bool redCircle = false;

  @override
  void initState() {
 
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   width: w(10),
          // ),
          BlocListener(
            bloc: notificationsBloc,
          
            listener: (context, state) {
              if (state is NotificationRingState) {
                log("here from ring state");
                _runAnimation();
              }
            },
            child: GestureDetector(
              onTap: () {
                nav(context, const Notifications());
              },
              child: container(
                hight: h(36),
                width: w(36),
                color: Colors.white,
                child: RotationTransition(
                    turns: Tween(begin: 0.0, end: -.1)
                        .chain(CurveTween(curve: Curves.elasticIn))
                        .animate(_animationController),
                    child: Icon(
                      Icons.notifications,
                      color: AppColor.darkBlue,
                      size: 30,
                    )),
              ),
            ),
          ),
          SizedBox(
            width: w(50),
          ),
          Image.asset("assets/images/logo.gif",
              fit: BoxFit.cover, width: w(170), height: h(30)),
          SizedBox(
            width: w(50),
          ),
          GestureDetector(
            onTap: () {
              nav(context, const Search());
            },
            child: container(
              hight: h(36),
              width: w(36),
              color: Colors.white,
              child: SvgPicture.asset(
                'assets/images/search.svg',
                height: h(25),
                width: w(25),
              ),
            ),
          ),

          // container(
          //   color: Colors.white,
          //   child: SvgPicture.asset(
          //     'assets/images/cart.svg',
          //     height: h(25),
          //     width: w(25),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _runAnimation() async {
    for (int i = 0; i < 3; i++) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }
}
