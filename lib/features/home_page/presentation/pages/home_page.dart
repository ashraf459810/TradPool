import 'package:flutter/material.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Widgets/bottom_navbar.dart';
import 'package:tradpool/features/buy/presentation/pages/buy.dart';
import 'package:tradpool/features/home/presentation/pages/home.dart';
import 'package:tradpool/features/like/presentation/pages/like.dart';
import 'package:tradpool/features/sell/presentation/pages/sell.dart';
import 'package:tradpool/features/settings/presentation/pages/profile.dart';

class HomePage extends StatefulWidget {
  final int index;
  const HomePage({Key key, this.index}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> routes = [
    const Home(),
    const Like(),
    const Buy(),
    const Sell(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
      List<NavBarItem> list = [
    NavBarItem("assets/images/home.svg",AppLocalizations.of(context).translate( "Home")),
    NavBarItem("assets/images/heart.svg", AppLocalizations.of(context).translate("Like")),
    NavBarItem("assets/images/buy.svg", AppLocalizations.of(context).translate("Buy")),
    NavBarItem("assets/images/sell.svg", AppLocalizations.of(context).translate("Sell")),
    NavBarItem("assets/images/settings.svg", AppLocalizations.of(context).translate("Settings"))
  ];

    return Scaffold(
      bottomNavigationBar: ButtomNavBar(
        index: widget.index ?? 0,
        navitems: list,
        routes: routes,
      ),
    );
  }
}
