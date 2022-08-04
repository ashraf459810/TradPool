import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';


import 'package:tradpool/App/app.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/core/consts.dart';
import 'package:tradpool/features/add_auction/presentation/pages/add_auction.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';
import 'package:tradpool/features/sell/data/models/all_auctions_model.dart';
import 'package:tradpool/features/sell/presentation/bloc/sell_bloc.dart';

import '../../../../Widgets/custom_list_view.dart';
import '../../../../Widgets/default_app_bar.dart';
import '../../../../injection_container.dart';


class Sell extends StatefulWidget {
  const Sell({Key key}) : super(key: key);

  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  ScrollController scrollController = ScrollController();

  int size = 100;
  int page = 0;
  List<UserAuctions> userAuztions = [];
  @override
  Widget build(BuildContext context) {
    log(DateTime.now().toString());

    return BlocProvider(
      create: (context) => sl<SellBloc>()..add(UserAuctionsEvent(page, size)),
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: h(40),
            ),
           SizedBox(height: h(40),
        width: w(300),
          child:const DefaultAppBar()),
           
            SizedBox(
              height: h(15),
            ),
            BlocConsumer<SellBloc, SellState>(
              listener: (context, state) {
                // if (state is Error) {
                //   Toast.show("error", context);
                // }
              },
              builder: (context, state) {
                if (state is SellInitial){
                    return const LoadingState();
                }
                if (state is Loading) {
                  return const LoadingState();
                }

                if (state is UserAuctionsState) {
                  
                  log(state.userAuctions.length.toString());
                  userAuztions = state.userAuctions;

                }
                if (state is Error){
                  Toast.show(state.error, context);
                }
                return
                    //  NotificationListener(
                    //   onNotification: (notification) {
                    //     if (scrollController.hasClients) {
                    //       if (notification.metrics.pixels == 0) {
                    //       } else {
                    //         page++;
                    //         context
                    //             .read<SellBloc>()
                    //             .add(UserAuctionsEvent(page, size));
                    //       }
                    //     }
                    //     return true;
                    //   },
                    //   child:
                    userAuztions.isNotEmpty
                        ? ListView(
                            controller: scrollController,
                            shrinkWrap: true,
                            children: [
                              container(
                                color: Colors.grey[50],
                                hight: h(580),
                                child: ListView.builder(
                                  itemCount: userAuztions.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: h(10)),
                                      child: GestureDetector(onTap: (() => nav(context, AuctionDetails(auctionId:userAuztions[index].id ))),
                                        child: 
                                          sellsItem(
                                  userAuztions[index].attachments.isNotEmpty?          userAuztions[index]
                                                .attachments[0]
                                                .publicUrl:"",
                                            userAuztions[index].brand?.name ??
                                                userAuztions[index]?.name ??
                                                "",
                                            userAuztions[index]
                                                .viewers
                                            
                                                .toString(),
                                          DateTime(0,0,0,0,),
                                            "${userAuztions[index].lastPrice ?? userAuztions[index].directSellPrice} AED",index),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : container(
                            hight: h(300),
                            child: text(
                                text: "You Didn't Add Any Ads Yet",
                                fontsize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blue));
                // );
                // : Column(
                //     children: [
                //       SizedBox(
                //         height: h(50),
                //       ),
                //       SizedBox(
                //         height: h(300),
                //         child: Center(
                //             child: text(
                //                 text: "No Auctions Added for you",
                //                 fontsize: 20.sp,
                //                 color: AppColor.blue)),
                //       ),
                //     ],
                //   );
              },
            ),
            SizedBox(
              height: h(10),
            ),
            InkWell(
              onTap: () {
                nav(context, const AddAuction());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w(30)),
                child: container(
                    child: text(text: "Add New", color: Colors.white),
                    color: AppColor.blue,
                    width: w(330),
                    hight: h(50)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sellsItem(
      String image, String brand, String bids, DateTime time, String price, index) {
    return container(
        color: Colors.white,
        borderRadius: 10,
        hight: h(140),
        width: w(350),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: w(10),
            ),
            SizedBox(
                height: h(120), width: w(120), child: Image.network(image)),
            SizedBox(
              width: w(10),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 15.h),
              child: SizedBox(
                width: w(180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
               
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/images/stupidicon.svg",
                          height: h(15),
                          width: w(15),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: w(10),
                        ),
                        text(
                            text: brand,
                            fontsize: 14.sp,
                            color: AppColor.hintcolor)
                      ],
                    ),
                    SizedBox(
                      height: h(8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/images/bids.svg",
                          height: h(15),
                          width: w(15),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: w(10),
                        ),
                        text(
                            text: bids,
                            fontsize: 14.sp,
                            color: AppColor.hintcolor)
                      ],
                    ),
                    SizedBox(
                      height: h(8),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SvgPicture.asset(
                        "assets/images/time.svg",
                        height: h(12),
                        width: w(10),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: w(10),
                      ),
                      text(
                          text: "${time.hour}"
                              "h:"
                              "${time.minute}"
                              "m:"
                              "${time.second}s",
                          fontsize: 14.sp,
                          color: AppColor.hintcolor)
                    ]),
                    SizedBox(
                      height: h(8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/images/pricee.svg",
                          height: h(15),
                          width: w(15),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: w(10),
                        ),
                        text(text: price, fontsize: 14.sp, color: Colors.red)
                      ],
                    ),
  customlistview(padding: 1,itemcount: userAuztions[index].tags.length,hight: h(30),
              width: w(200),
                      scroll: true,controller: ScrollController(),direction: "horizontal",function: (context,indexx){
                      return Card(
                        color: AppColor.blue,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: w(10)),
                          child: Center(child: SizedBox(child:  userAuztions[index].tags.isNotEmpty? text(text:userAuztions[index].tags[indexx],color: Colors.white,fontsize: 12.sp):const SizedBox())),
                        ));
                    }),
                  ],
                ),
              ),
            ),
            container(
                hight: h(36),
                width: w(36),
                child: SvgPicture.asset(
                  "assets/images/remove.svg",
                  fit: BoxFit.contain,
                ),
                color: AppColor.blue),
                 
          ],
        ));
  }
}
