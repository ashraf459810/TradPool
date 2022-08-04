import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Core/navigate_service.dart';
import 'package:tradpool/Widgets/app_builder.dart';

import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/auction_win_widget.dart';

import 'package:tradpool/features/splash/presentation/bloc/splash_bloc.dart';

import 'package:tradpool/features/splash/presentation/pages/splash.dart';

import '../features/settings/presentation/widgets/support_request_details.dart';
import '../injection_container.dart';
import 'app_localizations.dart';

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

String selectedNotificationPayload;

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print(message);
//   print('Handling a background message ${message.messageId}');
// }

AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final NavigationService navigationService = sl<NavigationService>();

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final navKey = GlobalKey<NavigatorState>();
  String id;

  String payload;

  @override
  void initState() {
    if (   sl<SharedPreferences>().getString("Language")==null){
        sl<SharedPreferences>().setString("Language", "English");}
    initializeNotifications();
    onMessageListen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) => 
       ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => BlocProvider(
          create: (BuildContext context) => sl<SplashBloc>(),
          child: MaterialApp(
              navigatorKey: sl<NavigationService>().navigatorKey,
              initialRoute: Splash.routeName,
              routes: <String, WidgetBuilder>{
                AuctionDetails.routeName: (_) => AuctionDetails(
                      auctionId: id,
                    ),
              },
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ar', 'AR'),
              ],
              locale: sl<SharedPreferences>().getString("Language")=="Arabic"? const Locale('ar', 'AR') : const Locale('en',"EN"),
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: const [
                // THIS CLASS WILL BE ADDED LATER
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                // Check if the current device locale is supported
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                // If the locale of the device is not supported, use the first one
                // from the list (English, in this case).
                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      primary: Colors.grey,
                      textStyle: TextStyle(fontSize: 16.sp)),
                ),
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hourMinuteShape: const CircleBorder(),
                ),
                textTheme: TextTheme(button: TextStyle(fontSize: 41.sp)),
              ),
              builder: (context, widget) {
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget,
                );
              },
              home: const Splash()),
        ),
      ),
    );
  }

  initializeNotifications() async {
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String title,
              String body,
              String payload,
            ) async {
              didReceiveLocalNotificationSubject.add(
                ReceivedNotification(
                  id: id,
                  title: title,
                  body: body,
                  payload: payload,
                ),
              );
            });
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (pay) async {
      var result = pay.split(',');
      if (result[0].contains('{redirectTo: /request-assistance-details')) {
        var id = result[2].substring(5, 41);
        log(id);

        sl<NavigationService>()
            .navigatorKey
            .currentState
            .push(MaterialPageRoute(
                builder: (context) => SupportRequestDetails(
                      requestId: id,
                    )));
      } 

            if (result[0].contains('{redirectTo: /auction-details')) {
        var id = result[2].substring(5, 41);
        log(id);

        sl<NavigationService>()
            .navigatorKey
            .currentState
            .push(MaterialPageRoute(
                builder: (context) => AuctionDetails(
                      auctionId: id,
                    )));
      } 





         if (result[0].contains('{redirectTo: /auction-winner')) {
          var id = result[2].substring(5,41);
          log(id);

          sl<NavigationService>()
              .navigatorKey
              .currentState
              .push(MaterialPageRoute(
                  builder: (context) => AuctionWinner(
                        auctionId: id,
                      )));
        } else {
        log('nope');
      }
    });
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      var token = await FirebaseMessaging.instance.getToken();
  
      await SharedPreferences.getInstance()
          .then((value) => value.setString(Con.fcmToken, token));
    }
  }

  onMessageListen() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      payload = message.data.toString();

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                playSound: true,
                
                sound: const RawResourceAndroidNotificationSound("notification"),

                channelDescription: channel.description,

                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ),
            payload: payload);
      }


    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

            if (message.data['redirectTo'] == '/request-assistance-details') {
        id = message.data['id'];
        log(id);

        sl<NavigationService>()
            .navigatorKey
            .currentState
            .push(MaterialPageRoute(
                builder: (context) => SupportRequestDetails(
                      requestId: id,
                    )));
      }







      if (message.data['redirectTo'] == '/auction-details') {
        id = message.data['id'];
        log(id);

        sl<NavigationService>()
            .navigatorKey
            .currentState
            .push(MaterialPageRoute(
                builder: (context) => AuctionDetails(
                      auctionId: id,
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
        }  else {
        log('nope');
      }
    });
  }
}

double h(double h) {
  return ScreenUtil().setHeight(h);
}

double w(double w) {
  return ScreenUtil().setWidth(w);
}
