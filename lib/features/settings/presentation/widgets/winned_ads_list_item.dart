
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/text.dart';

import 'package:tradpool/features/like/presentation/bloc/like_bloc.dart';

import '../../../../Widgets/custom_list_view.dart';
import '../../../../injection_container.dart';






// ignore: must_be_immutable
class WinnedAdsListItem extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final auction;
  final String id;
 final String category;
 final   double hight;
   final String image;
  final  Duration timeToFinish;
  final  String brand;
  final  String name;
 final   String  price;
   final String adsType;
 final   String location;
 final String fixedPrice;
  final  String viewers;
  final  String note;
   bool liked;
  WinnedAdsListItem({Key key, this.id, this.category, this.hight, this.image, this.timeToFinish, this.brand, this.name, this.price, this.adsType, this.location, this.viewers, this.note, this.fixedPrice, this.liked, this.auction}) : super(key: key);

  @override
  State<WinnedAdsListItem> createState() => _WinnedAdsListItemState();
}

class _WinnedAdsListItemState extends State<WinnedAdsListItem> {
 
  @override
  Widget build(BuildContext context) {
    return   listViewSample();
  }


 listViewSample(
  ) {
  return Card(
    child: container(

        hight: h(280),
        width: w(160),
        child:
         Row(mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Column(crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
              // shrinkWrap: true,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height:widget.hight ?? h(160),
                  color: Colors.green,
                  child: Stack(
                    children: [
                      container(
                          // color: Colors.green,
                  
                          child: Center(
                        child: widget.image != null
                            ? Image.network(
                               widget. image,
                                fit: BoxFit.fitWidth,
                                height: h(180),
                                width: 260.w,
                              )
                            : Image.asset(
                                "assets/images/sample.png",
                                fit: BoxFit.cover,
                                height: h(150),
                              ),
                      )),
        widget.liked !=null?      Positioned(
                         
                          child:
                              GestureDetector(onTap:  (){

                                if (widget.liked==false){
                  
                        sl<LikeBloc>().add(AddToFavouriteEvent(widget.id , 'like'));
                                }
                                else {

                                            sl<LikeBloc>().add(AddToFavouriteEvent(widget.id , 'unlike'));

                                }
                                widget.liked = !widget.liked;
                                setState(() {
                                  
                                });

                      },
                        child: 
                           Container(
                              height: h(30),
                              width: w(30),
                              decoration: const BoxDecoration(
                                shape:  BoxShape.circle,
                                color:Colors.white
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                "assets/images/heart.svg",
                                
                                fit: BoxFit.fill,
                                
                                color:  !widget.liked?  Colors.grey : AppColor.blue,
                              ))),
                  )):const SizedBox(),
                      
                      Positioned(
                        bottom: h(0),
                        right: w(0),
                        child: Opacity(
                          opacity: 0.8,
                          child: container(
                              hight: h(25),
                              width: w(265),
                              color: Colors.grey[100],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/clock.svg",
                                    height: h(15),
                                    width: w(15),
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: w(10),
                                  ),
                                  Countdown(
                                    duration:
                                      widget.  timeToFinish ?? const Duration(seconds: 0),
                                    onFinish: () {
                                 
                                    },
                                    builder:
                                        (BuildContext ctx, Duration remaining) {
                                      return Row(
                                        children: [
                                          remaining.inDays != 0
                                              ? Text(
                                                  '${remaining.inDays}days ',
                                                  style:
                                                      TextStyle(fontSize: 12.sp),
                                                )
                                              : const SizedBox(),
                                          Text(
                                            '${remaining.inHours.remainder(24)}H ',
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          Text(
                                            '${remaining.inMinutes.remainder(60)}M ',
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/views.svg"),
                      SizedBox(
                        width: w(10),
                      ),
                      text(
                          text: widget.viewers,
                          fontWeight: FontWeight.bold,
                          fontsize: 8.sp,
                          color: AppColor.hintcolor),
                      SizedBox(
                        width: w(20),
                      ),
                      SvgPicture.asset("assets/images/location.svg"),
                      SizedBox(
                        width: w(10),
                      ),
                      text(
                          text: widget.location,
                          fontWeight: FontWeight.bold,
                          fontsize: 8.sp,
                          color: AppColor.blue)
                    ],
                  ),
                ),
                SizedBox(height: h(2),),
   
 Center(
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: w(6),
                      ),
                                 text(
                          text: "Leading price",
                          fontWeight: FontWeight.bold,
                          fontsize: 10.sp,
                          color: AppColor.darkBlue),
                      
                      text(
                          text: widget.price ,
                          fontWeight: FontWeight.bold,
                          fontsize: 16.sp,
                          color: AppColor.darkBlue),
                      SizedBox(
                        width: w(3),
                      ),
                      
                      text(
                          text: "AED",
                          fontWeight: FontWeight.bold,
                          fontsize: 14.sp,
                          color: AppColor.darkBlue)
                    ],
                  ),
  ),


  widget.fixedPrice !=null ? Center(
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: w(6),
                      ),
                                 text(
                          text: "Fixed buy price",
                          fontWeight: FontWeight.bold,
                          fontsize: 10.sp,
                          color: AppColor.darkBlue),
                      
                      text(
                          text: widget.fixedPrice ?? "" ,
                          fontWeight: FontWeight.bold,
                          fontsize: 16.sp,
                          color: AppColor.darkBlue),
                      SizedBox(
                        width: w(3),
                      ),
                      
                      text(
                          text: "AED",
                          fontWeight: FontWeight.bold,
                          fontsize: 14.sp,
                          color: AppColor.darkBlue)
                    ],
                  ),
  ): 
   SizedBox(height:  h(5)),






                Row(
                  children: [
                    SizedBox(
                      width: w(5),
                    ),
                    text(text: widget. adsType ?? "Auction", color: AppColor.hintcolor),
                  ],
                ),
 
                
              ],
        ),
               widget.auction.sellerRate !=null && widget.auction.sellerFeedback!=null?        ratesAndFeedBack(widget.auction):const SizedBox(width: 1,)
           ],
         )
        ),
  );
}
  ratesAndFeedBack(dynamic auction) {return             Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
  crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                      auction.buyerRate!=null?              Row(
                                  children: [text(text: 'Buyer Rate',color: Colors.black,fontsize: 10.sp),
                                container(color: Colors.transparent,
                       hight: h(50),child: customlistview(padding: 1,
                                // width: w(120),
                                  hight: h(30),controller: ScrollController(),direction: 'horizontal',scroll: false,itemcount:  auction.buyerRate
                                //  auction.sellerRate
                           
                                 ,function: (context,index){
                                  return Icon(Icons.star ,  color: Colors.yellow[700],size: 15,);
                                }),)
                              ],
                                ):const SizedBox(),
                          auction.buyerFeedback !=null?      Column(
                            children: [
                              text(text: auction.buyerFeedback,fontsize: 10.sp,color: Colors.black),
                            ],
                          )
                              :const SizedBox()       ],
                                   ),
                  
                     
                                // :const SizedBox()

                                       Column(
                                         children: [
                                auction.sellerRate!=null?                   Row(
                                  children: [text(text: 'Seller Rate',color: Colors.black,fontsize: 10.sp),
                                container(color: Colors.transparent,
                       hight: h(50),child: customlistview(padding: 1,
                                // width: w(120),
                                  hight: h(30),controller: ScrollController(),direction: 'horizontal',scroll: false,itemcount: auction.sellerRate
                                //  auction.sellerRate
                           
                                 ,function: (context,index){
                                  return Icon(Icons.star ,  color: Colors.yellow[700],size: 15,);
                                }),)
                              ],
                                ):const SizedBox(),

                                                   auction.sellerFeedback !=null?      Row(
                                                     children: [
                                                       text(text: auction.sellerFeedback,fontsize: 10.sp,color: Colors.black),
                                                     ],
                                                   )
                              :const SizedBox()    

                                         ],
                                       ),


                              ],
                  ) ;///}
}}

