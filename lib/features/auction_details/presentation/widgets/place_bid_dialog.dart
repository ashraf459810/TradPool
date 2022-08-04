import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/auction_details/presentation/bloc/auction_details_bloc.dart';

placeBidDialog(
    {int autoBidMaxPrice,
    dynamic formKey,
    String auctionId,
    String step,
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
          auctionDetailsBloc.add(AddBidEvent(step, auctionId));
          auctionDetailsBloc.add(GetStepEvent(auctionId));

          Navigator.pop(context, true);
        } else {
          if (int.parse(bid) >= (autoBidMaxPrice) * 5) {
            _showMyDialog(
                context, bid.toString(), auctionDetailsBloc, step, auctionId);
          } else {
            if (formKey.currentState.validate()) {
              auctionDetailsBloc.add(AddBidEvent(bid, auctionId));
              auctionDetailsBloc.add(GetStepEvent(auctionId));
              Navigator.pop(context, true);
            } else {}
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
      height: h(288),
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
                            bidders[0].price.toString(),
                        color: AppColor.blue,
                        fontsize: 11.sp,
                        fontWeight: FontWeight.bold),
                  ],
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: text(
                text: AppLocalizations.of(context).translate(
                    "please make sure your price is equal or bigger than the recommended step"),
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
                              width: w(50),
                              hight: h(30),
                              color: Colors.white,
                              child: Wrap(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (int.parse(value) < int.parse(step)) {
                                        return "please raise the bid";
                                      } else {
                                        return null;
                                      }
                                    },
                                    initialValue: step,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          bottom: h(23), left: w(5)),
                                      // errorText: '',
                                      hintText: step,
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

Future<void> _showMyDialog(
    context,
    String bid,
    AuctionDetailsBloc auctionDetailsBloc,
    String step,
    String auctionId) async {
  showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.grey[100].withOpacity(1),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return SizedBox(
          height: h(300),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: h(300),
                    margin:
                        const EdgeInsets.only(bottom: 50, left: 12, right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: h(500),
                left: w(37),
                child: Center(
                  child: container(
                      hight: h(50),
                      width: w(300),
                      borderRadius: 30,
                      bordercolor: AppColor.blue,
                      child: Center(
                          child: Container(
                        child: text(
                            text: AppLocalizations.of(context).translate(
                                    "Do you really want to bid with") +
                                " $bid ?",
                            color: Colors.black,
                            fontsize: 12.sp),
                      ))),
                ),
              ),
              Positioned(
                top: h(570),
                left: w(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        auctionDetailsBloc.add(AddBidEvent(step, auctionId));
                        auctionDetailsBloc.add(GetStepEvent(auctionId));
                        Navigator.pop(context, true);
                        Navigator.pop(context, true);
                      },
                      child: container(
                          hight: h(30),
                          width: w(100),
                          borderRadius: 30,
                          color: AppColor.blue,
                          child: Center(
                            child: text(
                                text: "Yes", color: Colors.white, fontsize: 14),
                          )),
                    ),
                    SizedBox(
                      width: w(10),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                        Navigator.pop(context, true);
                      },
                      child: container(
                          hight: h(30),
                          width: w(100),
                          borderRadius: 30,
                          color: AppColor.blue,
                          child: Center(
                            child: text(
                                text: "No", color: Colors.white, fontsize: 14),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
}
