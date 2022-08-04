import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/core/consts.dart';
import 'package:tradpool/features/home_page/presentation/pages/home_page.dart';
import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';

class AuctionPlaced extends StatelessWidget {
  const AuctionPlaced({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/placed.svg"),
            SizedBox(
              height: h(30),
            ),
            text(
                text: "Ads Placed!",
                fontsize: 30.sp,
                color: AppColor.hintcolor),
            SizedBox(
              height: h(10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w(40)),
              child: text(
                  text:
                      "Your ad will be checked before being posted on Tradpool. This takes between 3 to 24 hours to be visible to potential buyers on Tradpool.Thank you for trusting Tradpool services.",
                  fontsize: 15.sp,
                  color: AppColor.hintcolor),
            ),
            SizedBox(
              height: h(70),
            ),
            InkWell(
                onTap: () {
                  nav(
                      context,
                      const HomePage(
                        index: 3,
                      ));
                },
                child: confirmButton(hint: AppLocalizations.of(context).translate( "Sell"), width: w(250))),
          ],
        ),
      ),
    );
  }
}
