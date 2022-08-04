import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/auction_details/presentation/bloc/auction_details_bloc.dart';

autoBidDialog(
    {dynamic formKey,
    String auctionId,
    int step,
    String bid,
    dynamic bidders,
    BuildContext context,
    String title,
    AuctionDetailsBloc auctionDetailsBloc}) {
  // set up the button
  Widget confirm = TextButton(
      style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: AppColor.blue,
          textStyle: TextStyle(
            fontSize: 10.sp,
          )),
      child: text(
        text: "Confirm",
      ),
      onPressed: () {
        if (bid == null) {
        } else {
          if (formKey.currentState.validate()) {
            auctionDetailsBloc.add(AutoBidEvent(auctionId, bid));
            // auctionDetailsBloc.add(GetStepEvent(auctionId));
            Navigator.pop(context, true);
          }
        }

        //  else {
        //   Toast.show("plase raise your Bid", context);
        // }
      });
  Widget cancel = TextButton(
    style: TextButton.styleFrom(
        side: BorderSide(color: AppColor.blue),
        primary: AppColor.blue,
        backgroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 10.sp,
        )),
    child: text(
      text: "Cancel",
    ),
    onPressed: () {
      bid = null;
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        text(
            text: title,
            color: AppColor.blue,
            fontsize: 20.sp,
            fontWeight: FontWeight.bold),
      ],
    ),
    content: SizedBox(
      height: h(290),
      width: w(300),
      child: Column(
        children: [
          bidders.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(
                        text: AppLocalizations.of(context)
                                .translate("Leaded By ") +
                            "${bidders[0].bidder.name}",
                        color: AppColor.blue,
                        fontsize: 10.sp,
                        fontWeight: FontWeight.bold),
                    text(
                        text: AppLocalizations.of(context)
                                .translate("  with price ") +
                            " ${bidders[0].price.toString()}",
                        color: AppColor.blue,
                        fontsize: 11.sp,
                        fontWeight: FontWeight.bold),
                  ],
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: text(
                text:
                    "please make sure your price is equal or bigger than zero",
                color: AppColor.darkBlue,
                fontsize: 11.sp,
                fontWeight: FontWeight.bold),
          ),
          Stack(
            children: [
              Opacity(
                  opacity: 0.1,
                  child: Container(
                    height: h(200),
                    width: w(200),
                    decoration: BoxDecoration(
                        color: AppColor.blue, shape: BoxShape.circle),
                  )),
              Positioned(
                top: h(50),
                left: w(50),
                child: Opacity(
                    opacity: 0.05,
                    child: Container(
                      height: h(100),
                      width: w(100),
                      decoration: BoxDecoration(
                          color: AppColor.blue, shape: BoxShape.circle),
                    )),
              ),
              Positioned(
                  top: h(80),
                  left: w(66),
                  child: SizedBox(
                    height: h(40),
                    child: Row(
                      children: [
                        Form(
                          key: formKey,
                          child: container(
                              width: w(70),
                              hight: h(30),
                              color: Colors.white,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.center,
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (int.parse(value) <= 0) {
                                        return "please raise the bid";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    initialValue: 0.toString(),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          bottom: h(23), left: w(5)),
                                      // errorText: '',
                                      hintText: '',
                                      errorStyle: TextStyle(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.bold),
                                      // contentPadding: EdgeInsets.only(bottom: h(0)),
                                      errorBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: AppColor.hintcolor,
                                          fontSize: 14.sp),
                                      border: InputBorder.none,
                                    ),
                                    // controller: bidc,
                                    onChanged: (val) {
                                      bid = val;
                                    },
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          width: w(20),
                        ),
                        text(
                            text: "AED",
                            color: AppColor.blue,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [confirm, cancel],
      )
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
