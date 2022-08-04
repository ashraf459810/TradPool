import 'dart:async';

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/bloc/app_bloc.dart';
import 'package:tradpool/Core/navigate_service.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/auction_win_widget.dart';

import 'package:tradpool/features/home_page/presentation/pages/home_page.dart';

import 'package:tradpool/features/login/presentation/pages/login.dart';
import 'package:tradpool/features/settings/presentation/widgets/support_request_details.dart';
import 'package:tradpool/features/splash/presentation/bloc/splash_bloc.dart';


import '../../../../injection_container.dart';

AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class Splash extends StatefulWidget {
  static const String routeName = '/';

  const Splash({
    Key key,
  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String payload;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  AppBloc appBloc = AppBloc();
  Timer timer;
  SplashBloc splashBloc = sl<SplashBloc>();

  @override
  void initState() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) async {
      if (message != null) {
  
        if (message.data['redirectTo'] == '/auction-details') {
          var id = message.data['id'];
          log(id);

          sl<NavigationService>()
              .navigatorKey
              .currentState
              .push(MaterialPageRoute(
                  builder: (context) => AuctionDetails(
                        auctionId: id,
                      )));
        } 

            if (message.data['redirectTo'] == '/request-assistance-details') {
          var id = message.data['id'];
          log(id);

          sl<NavigationService>()
              .navigatorKey
              .currentState
              .push(MaterialPageRoute(
                  builder: (context) => SupportRequestDetails(
                        requestId: id,
                      )));
        } 
           
              if (message.data['redirectTo'] == '/auction-winner') {
          var id = message.data['id'];
          log(id);

          sl<NavigationService>()
              .navigatorKey
              .currentState
              .push(MaterialPageRoute(
                  builder: (context) => AuctionWinner(
                        auctionId: id,
                      )));
        } 

        else {
          log('nope');
        }
      }
    });
    splashBloc.add(SaveFcmTokenEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    timer = Timer(const Duration(seconds: 3), () {
      appBloc.add(IsVerfiyEvent());
    });
    return Scaffold(
        key: scaffoldkey,
        body: BlocListener(
          bloc: appBloc,
          listener: (context, state) {
            if (state is IsVerfitState) {
              if (state.isverfiy) {
                log("verfied");
                navWithReplacement(context, const HomePage());
              } else {
                log("not verifird");
                navWithReplaceAll(context, const Login());
              }
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpeg"),
                    fit: BoxFit.cover)),
            child: Center(
                child: Image.asset(
              "assets/images/splash_00001.gif",
              height: h(150),
              width: w(300),
            )),
          ),
        ));
  }
}
