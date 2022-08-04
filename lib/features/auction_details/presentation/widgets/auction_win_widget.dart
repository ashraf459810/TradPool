import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:tradpool/App/app.dart';
import 'package:tradpool/Widgets/carousel_pro.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';

import 'package:tradpool/core/consts.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/auction_details/data/model/add_bid_response.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/presentation/bloc/auction_details_bloc.dart';

import 'package:tradpool/features/auction_details/presentation/widgets/bids_tab.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/details_tab.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/place_bid_dialog.dart';
import 'package:tradpool/features/buy/presentation/pages/buy.dart';

import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';

import '../../../../injection_container.dart';

class AuctionWinner extends StatefulWidget {
  static const String routeName = '/auctionDetails';
  final String auctionId;
  const AuctionWinner({Key key, this.auctionId}) : super(key: key);

  @override
  _AuctionWinnerState createState() => _AuctionWinnerState();
}

class _AuctionWinnerState extends State<AuctionWinner> {
  final formKey = GlobalKey<FormState>();
  var auctionDetailsBloc = sl<AuctionDetailsBloc>();
  bool isFirstBidDone = false;
  String bid;
  TextEditingController bidc = TextEditingController();
  bool isdetails = true;
  bool isbids = false;
  String step;
  bool firstTimeLoading = true;
  List<AddBidResponse> addBidsResponse = [];
  var bidders = [];
  dynamic auction;

  @override
  void initState() {
    auctionDetailsBloc.add(GetAuctionDetailsEvent(widget.auctionId));
    // timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('here from auction details ');
    // log(widget.auctionId);
    return BlocBuilder(
      bloc: auctionDetailsBloc,
      builder: (context, state) {
        if (state is Loading && firstTimeLoading) {
          firstTimeLoading = false;
          return const Scaffold(body: Center(child: LoadingState()));
        }

        if (state is GetAuctionState) {
          log("here the state ");
          auction = state.auctionDetails;

          bidders = state.auctionDetails.bidRequests;

          // auctionDetailsBloc.add(GetStepEvent(widget.auctionId));
        }

        return auction != null
            ? Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(h(70)),
                  child: Padding(
                    padding: EdgeInsets.all(h(8.0)),
                    child: AppBar(
                      iconTheme: const IconThemeData(color: Colors.black),
                      title: Column(
                        children: [
                  
                            
                          text(
                              text: "Auction End",
                              color: Colors.grey,
                              fontsize: 16.sp)
                        ],
                      ),
                      centerTitle: true,
                      foregroundColor: Colors.grey[50],
                      backgroundColor: Colors.grey[50],
                      elevation: 0,
                      actions: [
                        SizedBox(
                          width: w(100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text(
                                  text: "Share ",
                                  color: Colors.grey,
                                  fontsize: 14.sp),
                              SvgPicture.asset(
                                "assets/images/share.svg",
                                height: h(16),
                                width: w(16),
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                body: Center(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: h(20),
                      ),
                      SizedBox(
                        height: h(160),
                        width: w(300),
                        child: Carousel(
                          autoplay: true,
                          showIndicator: true,
                          moveIndicatorFromBottom: 0,
                          dotSize: h(5),
                          indicatorBgPadding: 0,

                          // dotColor: AppColor.blue,
                          borderRadius: true,

                          // dotSize: 10.sp,
                          images: getImages(auction.attachments).isNotEmpty
                              ? getImages(auction.attachments)
                                  .map((e) => Image.network(e))
                                  .toList()
                              :
                              // [
                              [
                                  Image.network(
                                      "https://m.media-amazon.com/images/I/81s4pCnbMfS._SL1500_.jpg"),
                                  Image.network(
                                      "https://m.media-amazon.com/images/I/81s4pCnbMfS._SL1500_.jpg"),
                                ],
                        ),
                      ),
                      SizedBox(
                        height: h(30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: w(20),
                          ),
                          SvgPicture.asset(
                            "assets/images/stupidicon.svg",
                            height: h(20),
                            width: w(20),
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: w(10),
                          ),
                          text(
                              text: auction.brand!=null? auction.brand.name ??
                                  auction.mainCategory.name ??
                                  '':auction.name,
                              fontsize: 16.sp,
                              color: AppColor.hintcolor)
                        ],
                      ),
                      SizedBox(
                        height: h(10),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: h(30)),
                            child: text(text: auction.description),
                          )
                        ],
                      ),
                      SizedBox(
                        height: h(30),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(100)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isdetails = true;
                                  isbids = false;
                                });
                              },
                              child: container(
                                  color: Colors.white,
                                  borderRadius: 30,
                                  width: w(70),
                                  hight: h(30),
                                  child: Center(
                                      child: text(
                                          text: "Details",
                                          fontsize: 12.sp,
                                          color: isdetails
                                              ? AppColor.blue
                                              : AppColor.hintcolor))),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isdetails = false;
                                  isbids = true;
                                });
                              },
                              child: container(
                                  color: Colors.white,
                                  borderRadius: 30,
                                  width: w(70),
                                  hight: h(30),
                                  child: Center(
                                      child: text(
                                          text: "Bids",
                                          fontsize: 12.sp,
                                          color: isbids
                                              ? AppColor.blue
                                              : AppColor.hintcolor))),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h(30),
                      ),
                      isdetails
                          ? Column(
                              children: [
                                detailsTap(
                                    true,
                                    "assets/images/brand.svg",
                                    "assets/images/sku.svg",
                                    "Brand",
                           auction.brand!=null?         auction.brand.name ?? auction.name ?? "":auction.name,
                                    "Name",
                                    auction.name ?? ''),
                                SizedBox(
                                  height: h(30),
                                ),
                                detailsTap(
                                    true,
                                    "assets/images/condiation.svg",
                                    "assets/images/weight.svg",
                                    "Condition",
                                    "new",
                                    "Weight & dimensions",
                                    "${auction.width ?? ""} * ${auction.height ?? ""}"),
                                SizedBox(
                                  height: h(30),
                                ),
                                detailsTap(
                                    auction.directSellPrice != null
                                        ? true
                                        : false,
                                    "assets/images/category.svg",
                                    "assets/images/price.svg",
                                    "Type",
                                    auction.subCategory.name ?? "",
                                    "Direct buy price",
                          ''),
                                SizedBox(
                                  height: h(30),
                                ),
                                detailsTap(
                                    false,
                                    "assets/images/startprice.svg",
                                    "assets/images/minprice.svg",
                                    "Start price",
                                    "${auction.startPrice ?? "_ " "AED"}",
                                    "Reservation price",
                                    "${auction.directSellPrice ?? "_"} ?? AED"),
                              ],
                            )
                          : SizedBox(
                              child: ListView(shrinkWrap: true, children: [
                                bidders.isNotEmpty
                                    ? SizedBox(
                                        height: h(300),
                                        child: ListView.builder(
                                          itemCount: bidders.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: bidsTap(
                                                  "assets/images/avatar.svg",
                                                 Text( bidders[index].bidder.name),
                                                  "${bidders[index].creationDate.day}/${bidders[index].creationDate.month}/${bidders[index].creationDate.year} || ${bidders[index].creationDate.hour}:${bidders[index].creationDate.minute}",
                                                  "Bid Amount",
                                                  bidders[index]
                                                      .price
                                                      .toString(),
                                                  index),
                                            );
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                             
                              ]),
                            ),
                      !isbids
                          ? Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (step != null) {
                                      placeBidDialog(
                                          auctionDetailsBloc:
                                              auctionDetailsBloc,
                                          auctionId: widget.auctionId,
                                          bid: bid,
                                          bidders: bidders,
                                          context: context,
                                          formKey: formKey,
                                          step: step,
                                          title: 'enter your price');
                                    }
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h(10), horizontal: w(50)),
                                      child: InkWell(
                                        onTap: (){nav(context, const Buy());},
                                        child: confirmButton(hint:'continue'))),
                                ),
                         
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              )
            : const Scaffold();
      },
    );
  }

  String showdate(DateTime dateTime) {
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return date;
  }

  List<String> getImages(List<Attachment> attachments) {
    List<String> auctionsImages = [];
    if (attachments.isNotEmpty) {
      for (var i = 0; i < attachments.length; i++) {
        auctionsImages.add(attachments[i].publicUrl);
      }
      return auctionsImages;
    } else {
      return auctionsImages;
    }
  }

  void timer() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (mounted) {
        setState(() {
          auctionDetailsBloc.add(GetAuctionDetailsEvent(widget.auctionId));
          // Anything else you want
        });
        timer();
      }
    });
  }

}