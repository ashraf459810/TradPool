import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Widgets/carousel_pro.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/custom_list_view.dart';
import 'package:tradpool/Widgets/text.dart';

import 'package:tradpool/core/consts.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/auction_details/data/model/add_bid_response.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';
import 'package:tradpool/features/auction_details/presentation/bloc/auction_details_bloc.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/auto_bid_dialog.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/bids_tab.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/chat_room.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/details_tab.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/image_widget.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/place_bid_dialog.dart';
import 'package:tradpool/features/auction_details/presentation/widgets/timer.dart';

import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';

import '../../../../Widgets/nav.dart';
import '../../../../injection_container.dart';
import '../../../settings/presentation/widgets/user_history.dart';

class AuctionDetails extends StatefulWidget {
  static const String routeName = '/auctionDetails';
  final String auctionId;
  const AuctionDetails({Key key, this.auctionId}) : super(key: key);

  @override
  _AuctionDetailsState createState() => _AuctionDetailsState();
}

class _AuctionDetailsState extends State<AuctionDetails> {
  final formKey = GlobalKey<FormState>();
  var auctionDetailsBloc = sl<AuctionDetailsBloc>();
  bool isFirstBidDone = false;
  String bid;
  TextEditingController bidc = TextEditingController();
  bool isdetails = true;
  bool isbids = false;
  String step;
  bool firstTimeLoading = true;
  bool manualBidButtonEnabled = true;
  bool autoBidButtonEnabled = false;
  bool updateAutoBidButtonEnabled = false;
  int autoBidMaxPrice;
  bool withdrawenabled = false;
  bool directbuyenabled = false;
  List<AddBidResponse> addBidsResponse = [];
  bool canRate = false;
  bool isBuyerToRate = false;
  bool isSellerToRate = false;
  bool cancelButton = false;
  bool markAsDeliveredButtonEnabled = false;
  var bidders = [];
  dynamic auction;
  String messageButtonLabel = '';
  bool chatEnabled = false;
  List<Message> messages = [];

  @override
  void initState() {
    auctionDetailsBloc.add(GetAuctionDetailsEvent(widget.auctionId));
    timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.auctionId);
    return BlocBuilder(
      bloc: auctionDetailsBloc,
      builder: (context, state) {
        if (state is Loading && firstTimeLoading) {
          firstTimeLoading = false;
          return const Scaffold(body: Center(child: LoadingState()));
        }

        if (state is GetAuctionState) {
          messages = state.auctionDetails.messages ??[];
          chatEnabled = state.auctionDetails.sendMessageButtonEnabled;
          messageButtonLabel = state.auctionDetails.sendMessageButtonLabel;
          autoBidMaxPrice = state.auctionDetails.autoBidMaxPrice;

          directbuyenabled = state.auctionDetails.directBuyButtonEnabled;
          withdrawenabled = state.auctionDetails.withdrawButtonEnabled;
          autoBidButtonEnabled = state.auctionDetails.autoBidButtonEnabled;
          manualBidButtonEnabled = state.auctionDetails.manualBidButtonEnabled;

          cancelButton = state.auctionDetails.cancelButtonEnabled;
                
          markAsDeliveredButtonEnabled =
              state.auctionDetails.markAsDeliveredButtonEnabled;
          updateAutoBidButtonEnabled =
              state.auctionDetails.updateAutoBidButtonEnabled;

          log("here from auction details the state ");
          auction = state.auctionDetails;

          bidders = state.auctionDetails.bidRequests;

          auctionDetailsBloc.add(GetStepEvent(widget.auctionId));

          canRate = state.auctionDetails.sellerFeedbackEnabled ||
              state.auctionDetails.buyerFeedbackEnabled;
          isBuyerToRate = state.auctionDetails.buyerFeedbackEnabled;
          isSellerToRate = state.auctionDetails.sellerFeedbackEnabled;
        }
        if (state is GetStepState) {
          log('here the step');
          step = state.step['nextPrice'].toString();
          autoBidMaxPrice = state.step['maxPrice'];
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
                          timerWidget(
                            Duration(
                                days:
                                    int.parse(auction.timeToEnd.split(':')[0].substring(1,2) ),
                                hours:
                                    int.parse(auction.timeToEnd.split(':')[1].substring(1,2) ),
                                minutes:
                                    int.parse(auction.timeToEnd.split(':')[2].substring(1,2) )),
                          ),
                          text(
                              text: "Auction Ending",
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
                                  text: "Share",
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
                  child: Scrollbar(
                    interactive: false,
                    thickness: 5,
       
 
                   
                    child: ListView(
                      children: [
                        SizedBox(
                          height: h(20),
                        ),
                        SizedBox(
                          height: h(170),
                          width: w(300),
                          child: Carousel(
                            autoplay: true,
                            showIndicator: true,
                            moveIndicatorFromBottom: 0,
                            dotSize: h(5),
                            indicatorBgPadding: 0,
                            onImageTap: (value) {
                              nav(
                                  context,
                                  ImageZoom(
                                      image: getImages(
                                          auction.attachments)[value]));
                            },

                            // dotColor: AppColor.blue,
                            borderRadius: true,

                            // dotSize: 10.sp,
                            images: getImages(auction.attachments).isNotEmpty
                                ? getImages(auction.attachments)
                                    .map((e) => Image.network(
                                          e,
                                          fit: BoxFit.contain,
                                        ))
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                SizedBox(
                                  child: text(
                                      text: auction.brand != null
                                          ? auction.brand.name ??
                                              auction.mainCategory.name ??
                                              ''
                                          : auction.name,
                                      fontsize: 16.sp,
                                      color: AppColor.hintcolor),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                
                                GestureDetector(
                                  onTap: () {
                                    navWithReplacement(
                                        context,
                                        UserHistory(
                                            auctionId: widget.auctionId));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      text(text: "Seller", fontsize: 10.sp),
                                      SizedBox(
                                        width: w(10),
                                      ),
                                      text(
                                          text: auction.seller.name,
                                          fontsize: 16.sp,
                                          color: AppColor.blue),
                                          SizedBox(width:30.w,),
                                       
                                        
                                    ],
                                  ),
                                )
                              ],
                            )
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
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h(30),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w(0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              container(
                                
                                    color: Colors.white,
                                    borderRadius: 30,
                                    width: w(70),
                                    hight: h(30),
                                    child: GestureDetector(onTap: (() {
                                               
                                                 if (chatEnabled){
                                                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChatRoom(messages: messages ,auctionId: widget.auctionId,),));
                             
                                                 }
                                                 else {
                                                   Toast.show(AppLocalizations.of(context).translate( "chat disabled until you win the auction"), context);
                                                 }
                                               }),
                                                 child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                   children: [
                                                           Icon(Icons.chat,color:AppColor.blue ,size: 20,),
                                                    //  text(text: messageButtonLabel,fontsize: 10.sp),
                                                                                       
                                                   ],
                                                 ),
                                               
                                             
                                       )  ),
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
                                 AppLocalizations.of(context).translate("Brand"),
                                      auction.brand != null
                                          ? auction.brand.name ??
                                              auction.name ??
                                              ""
                                          : auction.name,
                             AppLocalizations.of(context).translate("Name"),
                                      auction.name ?? ''),
                                  SizedBox(
                                    height: h(30),
                                  ),
                                  detailsTap(
                                      true,
                                      "assets/images/condiation.svg",
                                      "assets/images/weight.svg",
                                     AppLocalizations.of(context).translate( "Condition"),
                                      auction.productCondition,
                               AppLocalizations.of(context).translate(       "Weight & dimensions"),
                                      "${auction.width ?? ""} * ${auction.height ?? ""}"),
                                  SizedBox(
                                    height: h(30),
                                  ),
                                  auction.autoBidMaxPrice != null
                                      ? detailsTap(
                                          true,
                                          "assets/images/startprice.svg",
                                          "assets/images/minprice.svg",
                                          "Start price",
                                          "${auction.startPrice ?? "_ " "AED"}",
                                          "your auto bid max price",
                                          "${auction.autoBidMaxPrice ?? '-'} AED")
                                      : const SizedBox(),
                                  detailsTap(
                                    auction.directSellPrice != null
                                        ? true
                                        : false,
                                    "assets/images/category.svg",
                                    "assets/images/price.svg",
                                    "Type",
                                    auction.subCategory.name ?? "",
                                    "Direct buy price",
                                    auction.directSellPrice.toString(),
                                  ),
                                  auction.lastUserBid != null
                                      ? SizedBox(
                                          height: h(30),
                                        )
                                      :const SizedBox(),
                                  auction.lastUserBid != null
                                      ? detailsTap(
                                          false,
                                          "assets/images/price.svg",
                                          "assets/images/price.svg",
                                          "last User Bid",
                                          auction.lastUserBid.toString() ??
                                              0.toString(),
                                          "Direct buy price",
                                          '')
                                      : const SizedBox(),
                                  Column(
                                    children: [
                                      SizedBox(height: 20.h,),
                                      ratesAndFeedBack(),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(
                                child: ListView(shrinkWrap: true, children: [
                                  bidders.isNotEmpty
                                      ? SizedBox(
                                          height: h(230),
                                          child: ListView.builder(
                                            itemCount: bidders.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: bidsTap(
                                                    "assets/images/avatar.svg",
                                                    text(
                                                        text: bidders[index]
                                                            .bidder
                                                            .name,
                                                        fontsize: 12.sp,
                                                        color: index == 0
                                                            ? AppColor.blue
                                                            : Colors.black),
                                                    "${bidders[index].creationDate.day}/${bidders[index].creationDate.month}/${bidders[index].creationDate.year} || ${bidders[index].creationDate.hour}:${bidders[index].creationDate.minute}",
                                                 AppLocalizations.of(context).translate(   "Bid Amount"),
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
                        Column(
                          children: [
                            manualBidButtonEnabled
                                ? GestureDetector(
                                    onTap: () {
                                      if (step != null) {
                                        placeBidDialog(
                                            autoBidMaxPrice: autoBidMaxPrice,
                                            auctionDetailsBloc:
                                                auctionDetailsBloc,
                                            auctionId: widget.auctionId,
                                            bid: bid,
                                            bidders: bidders,
                                            context: context,
                                            formKey: formKey,
                                            step: step,
                                            title: AppLocalizations.of(context).translate( 'enter your price'));
                                      }
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: h(10), horizontal: w(50)),
                                        child: placeBidButton()),
                                  )
                                : const SizedBox(),
                            (autoBidButtonEnabled || updateAutoBidButtonEnabled)
                                ? GestureDetector(
                                    onTap: () {
                                      autoBidDialog(
                                          formKey: formKey,
                                          auctionDetailsBloc:
                                              auctionDetailsBloc,
                                          auctionId: widget.auctionId,
                                          context: context,
                                          title: 'Enter Max Price',
                                          bidders: bidders);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h(10), horizontal: w(50)),
                                      child: confirmButton(
                                        hint: updateAutoBidButtonEnabled
                                            ?  "Update auto bid"
                                            : "Enable auto bid",
                                        color: AppColor.hintcolor,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            withdrawenabled
                                ? GestureDetector(
                                    onTap: () {
                                      auctionDetailsBloc
                                          .add(WithdrawEvent(widget.auctionId));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h(10), horizontal: w(50)),
                                      child: BlocConsumer(
                                        bloc: auctionDetailsBloc,
                                        listener: (context, state) {
                                          if (state is Error) {
                                            Toast.show(state.error, context,
                                                gravity: 1, duration: 4);
                                          }

                                          if (state is WithdrawState) {
                                            Toast.show(
                                             AppLocalizations.of(context).translate(   'you withdrawed succeccfully'),
                                                context,
                                                gravity: 1,
                                                duration: 4);
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is LoadingWithdrawState) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                          return confirmButton(
                                            hint: "Withdraw",
                                            color: AppColor.hintcolor,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: h(10),
                            ),
                            directbuyenabled
                                ? GestureDetector(
                                    onTap: () {
                                      auctionDetailsBloc
                                          .add(BuyNowEvent(widget.auctionId));
                                    },
                                    child: BlocConsumer(
                                      bloc: auctionDetailsBloc,
                                      listener: (context, state) {
                                        if (state is Error) {
                                          Toast.show(state.error, context,
                                              gravity: 1, duration: 4);
                                        }

                                        if (state is BuyNowState) {
                                          Toast.show(AppLocalizations.of(context).translate( 'you bought succeccfully'),
                                              context,
                                              gravity: 1, duration: 4);
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is LoadingBuyNowState) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: h(10),
                                              horizontal: w(50)),
                                          child: confirmButton(
                                            hint: AppLocalizations.of(context).translate( "Direct Buy"),
                                            color: AppColor.hintcolor,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                            canRate
                                ? GestureDetector(
                                    onTap: () {
                                      showRateDialog();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h(10), horizontal: w(50)),
                                      child: confirmButton(
                                        hint: AppLocalizations.of(context).translate( "FeedBack"),
                                        color: AppColor.hintcolor,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            cancelButton
                                ? GestureDetector(
                                    onTap: () async {
                                      Client client = Client();

                                      var token = sl<SharedPreferences>()
                                          .get(Con.token);
                                      var response = await client.post(Uri.parse(
                                          'http://159.89.51.204:8080/tradepool/buy-and-sell/cancel-sell-request?sellRequest=${widget.auctionId}&user=$token'));
                                      if (response.statusCode == 200) {
                                        Toast.show(
                                          AppLocalizations.of(context).translate( "Canceld Successfully"), context);
                                      } else {
                                        Toast.show("server error", context);
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h(10), horizontal: w(50)),
                                      child: confirmButton(
                                        hint:AppLocalizations.of(context).translate( "Cancel Request"),
                                        color: Colors.red[900],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            markAsDeliveredButtonEnabled
                                ? GestureDetector(
                                    onTap: () async {
                                      Client client = Client();

                                      var token = sl<SharedPreferences>()
                                          .get(Con.token);
                                      var response = await client.post(Uri.parse(
                                          'http://159.89.51.204:8080/tradepool/buy-and-sell/mark-sell-request-as-delivered?sellRequest=${widget.auctionId}&user=$token'));
                                      if (response.statusCode == 200) {
                                        Toast.show(
                                         AppLocalizations.of(context).translate(   "marked Successfully"), context);
                                      } else {
                                        Toast.show("server error", context);
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h(10), horizontal: w(50)),
                                      child: confirmButton(
                                        hint: AppLocalizations.of(context).translate( "Cancel Request"),
                                        color: Colors.red[900],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const Scaffold();
      },
    );
  }

  showRateDialog() {
    final _dialog = RatingDialog(
      // your app's name?
      title: text(text: 'Rating'),
      // encourage your user to leave a high rating?
      message: text(
          text:
              'Tap a star to set your rating. Add more description here if you want.'),
      // your app's logo?
      image: Image.asset("assets/images/logo.gif"),
      submitButtonText: 'Submit',
      onCancelled: () => log('cancelled'),
      onSubmitted: (response) {
        String type;
   
        if (isBuyerToRate) {
          type = 'buyer';
        } else {
          type = "seller";
        }
        auctionDetailsBloc.add(AddRateAndFeedBackEvent(
            response.rating.toInt().toString(),
            response.comment,
            widget.auctionId,
            type));

        Navigator.of(context).pop();
        Toast.show( AppLocalizations.of(context).translate("thanks For your Feedback"), context);
      },
    );

// show the dialog
    showDialog(
      context: context,
      builder: (context) => _dialog,
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

  Widget placeBidButton() {
    return BlocConsumer(
      bloc: auctionDetailsBloc,
      listener: (context, state) {
        if (state is AutoBidState) {

          Toast.show(AppLocalizations.of(context).translate('AutoBid Enabled Successfully'), context,
              gravity: 2, duration: 4);
          auctionDetailsBloc.add(GetStepEvent(widget.auctionId));
        }
        if (state is AddBidState) {
          isFirstBidDone = true;

          Toast.show(AppLocalizations.of(context).translate( 'Added Successfully'), context, gravity: 2, duration: 4);
          auctionDetailsBloc.add(GetStepEvent(widget.auctionId));
        }
        if (state is Error) {
          Toast.show(state.error, context, gravity: 2, duration: 4);
        }
        if (state is GetStepState) {
          step = state.step['nextPrice'].toString();
          autoBidMaxPrice = state.step['maxPrice'];
       
        }
      },
      builder: (context, state) {
        if (state is AddBidState) {
          isFirstBidDone = true;
          bidders = state.addBidResponse.bidRequests;
        }
        if (state is AddBidState) {
          auctionDetailsBloc.add(GetAuctionDetailsEvent(widget.auctionId));
          bid = null;
        }
        return confirmButton(
          hint: AppLocalizations.of(context).translate( "place a Bid"),
          color: AppColor.blue,
        );
      },
    );
  }

 Widget ratesAndFeedBack() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  auction.buyerRate != null
                      ? Row(
                          children: [
                            text(
                                text: 'Buyer Rate',
                                color: Colors.black,
                                fontsize: 10.sp),
                            container(
                              color: Colors.transparent,
                              hight: h(50),
                              child: customlistview(
                                  padding: 1,
                                  // width: w(120),
                                  hight: h(30),
                                  controller: ScrollController(),
                                  direction: 'horizontal',
                                  scroll: false,
                                  itemcount: auction.buyerRate
                                  //  auction.sellerRate
      
                                  ,
                                  function: (context, index) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.yellow[700],
                                      size: 15,
                                    );
                                  }),
                            )
                          ],
                        )
                      : const SizedBox(),
                  auction.buyerFeedback != null
                      ? Row(
                          children: [
                            // text(text: "Buyer Feedback", fontsize: 10.sp),
                      
                            Column(
                              children: [
                                text(
                                    text: auction.buyerFeedback,
                                    fontsize: 10.sp,
                                    color: Colors.black),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox()
                ],
              ),
      
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  auction.sellerRate != null
                      ? Row(
                          children: [
                            text(
                                text: 'Seller Rate',
                                color: Colors.black,
                                fontsize: 10.sp),
                            container(
                              color: Colors.transparent,
                              hight: h(50),
                              child: customlistview(
                                  padding: 1,
                                  // width: w(120),
                                  hight: h(30),
                                  controller: ScrollController(),
                                  direction: 'horizontal',
                                  scroll: false,
                                  itemcount: auction.sellerRate
                                  //  auction.sellerRate
      
                                  ,
                                  function: (context, index) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.yellow[700],
                                      size: 15,
                                    );
                                  }),
                            )
                          ],
                        )
                      : const SizedBox(),
                  auction.sellerFeedback != null
                      ? Column(
                        children: [
                          text(
                              text: auction.sellerFeedback ,
                              fontsize: 10.sp,
                              color: Colors.black),
                        ],
                      )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );

    ///}
  }
}
