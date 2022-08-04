import 'dart:io';

import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:tradpool/App/app.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));

  // before the runApp() call

  await di.init();

  // Than we setup preferred orientations,
  // and only after it finished we run our app

       runApp(const MyApp());
}


 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}