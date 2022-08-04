
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/text.dart';


import '../../../../Widgets/custom_list_view.dart';







// ignore: must_be_immutable
class UserHistoryItem extends StatefulWidget {
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
  UserHistoryItem({Key key, this.id, this.category, this.hight, this.image, this.timeToFinish, this.brand, this.name, this.price, this.adsType, this.location, this.viewers, this.note, this.fixedPrice, this.liked, this.auction}) : super(key: key);

  @override
  State<UserHistoryItem> createState() => _UserHistoryItemState();
}

class _UserHistoryItemState extends State<UserHistoryItem> {
 
  @override
  Widget build(BuildContext context) {
    return   listViewSample();
  }


 listViewSample(
  ) {
  return Card(
    child: container(

        hight: widget.auction.buyerRate !=null || widget.auction.sellerRate !=null ? h(380) :h(280),
        width: w(160),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start  ,
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
                            height: h(160),
                            width: w(280),
                          )
                        : Image.asset(
                            "assets/images/sample.png",
                            fit: BoxFit.cover,
                            height: h(150),
                          ),
                  )),
    
                  
                  Positioned(
                    bottom: h(0),
                 
                    child: Opacity(
                      opacity: 0.8,
                      child: container(
                          hight: h(25),
                          width: w(300),
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
   
  widget.price !="_"? Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: w(6),
                ),
                           text(textAlign: TextAlign.left,
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
            ):const SizedBox(),


  widget.fixedPrice !=null ? Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: w(6),
                ),
                           text(
                             textAlign: TextAlign.left,
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
            ): 
   SizedBox(height:  h(30)),

   widget.price=="_"? SizedBox(height: h(30),):const SizedBox(),




            Row(
              children: [
                SizedBox(
                  width: w(5),
                ),
                text(text: widget. adsType ?? "Auction", color: AppColor.hintcolor),
              ],
            ),
    
          
       widget.auction.buyerRate!=null?              Padding(
         padding:  EdgeInsets.symmetric(horizontal: 8.w),
         child: Row(
                     children: [
                      text(text: 'Buyer Rate',color: Colors.black,fontsize: 10.sp),
                   container(color: Colors.transparent,
          hight: h(40),child: customlistview(padding: 1,
                   // width: w(120),
                     hight: h(30),controller: ScrollController(),direction: 'horizontal',scroll: false,itemcount:widget.auction.buyerRate
                   //  auction.sellerRate
              
                    ,function: (context,index){
                     return Icon(Icons.star ,  color: Colors.yellow[700],size: 20,);
                   }),)
                 ],
                   ),
       ):const SizedBox(),
           widget.auction.buyerFeedback !=null?      Padding(
             padding:EdgeInsets.symmetric(horizontal: 8.w),
             child: text(text:"Buyer Feedback"       " "+ widget.auction.buyerFeedback,fontsize: 10.sp,color: AppColor.blue),
           )
               :const SizedBox()  ,     
                    
              
                 
                 // :const SizedBox()

                  
                widget.auction.sellerRate!=null?                   Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                     children: [text(text: 'Seller Rate',color: Colors.black,fontsize: 10.sp),
                   container(color: Colors.transparent,
        hight: h(40),child: customlistview(padding: 1,
                   // width: w(120),
                     hight: h(30),controller: ScrollController(),direction: 'horizontal',scroll: false,itemcount:widget.auction.sellerRate
                   //  auction.sellerRate
            
                    ,function: (context,index){
                     return Icon(Icons.star ,  color: Colors.yellow[700],size: 20,);
                   }),)
               ],
                   ),
                ):const SizedBox(),

                                    widget.auction.sellerFeedback !=null?      Padding(
                                      padding:EdgeInsets.symmetric(horizontal: 8.w),
                                      child: text(text: "Buyer Feedback"       " "+widget.auction.sellerFeedback,fontsize: 10.sp,color: AppColor.blue),
                                    )
               :const SizedBox(),


        
   
          ],
        )),
  );
}
 
}

