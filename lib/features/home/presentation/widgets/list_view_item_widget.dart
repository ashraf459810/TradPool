
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/custom_list_view.dart';
import 'package:tradpool/Widgets/text.dart';

import 'package:tradpool/features/like/presentation/bloc/like_bloc.dart';

import '../../../../injection_container.dart';






// ignore: must_be_immutable
class ListViewSample extends StatefulWidget {
  final List<String >tags;
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
  final String subscriptionType;
   bool liked;
  ListViewSample({Key key, this.id, this.category, this.hight, this.image, this.timeToFinish, this.brand, this.name, this.price, this.adsType, this.location, this.viewers, this.note, this.fixedPrice, this.liked, this.tags, this.subscriptionType}) : super(key: key);

  @override
  State<ListViewSample> createState() => _ListViewSampleState();
}

class _ListViewSampleState extends State<ListViewSample> {
 
  @override
  Widget build(BuildContext context) {
    return   listViewSample();
  }


 listViewSample(
  ) {
  return Card(
    child: container(

        hight: h(250),
        width: w(160),
        child: Wrap(
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
                            fit: BoxFit.cover,
                            height: h(160),
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
                          width: w(170),
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
                                  widget.  timeToFinish ??const Duration(seconds: 0),
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
                      Positioned(top: 100.h,
                        child: Container(color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: text(text: widget.subscriptionType=="BOUTIQUE" ? "BOUTIQUE" : "",color: Colors.white,fontsize: 12.sp),
                          )),
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
   
  widget.price !="_"? Center(
    child: Row(mainAxisAlignment: MainAxisAlignment.start,
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
                      text: widget.price ??"",
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
  ):const SizedBox(),


  widget.fixedPrice !="_" ? Center(
    child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: w(6),
                  ),
                             text(
                      text:  "Fixed buy price",
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
      widget.tags!=null?          customlistview(padding: 1,itemcount:widget. tags.length,hight: h(30),
            width: w(200),
                    scroll: true,controller: ScrollController(),direction: "horizontal",function: (context,index){
                    return Card(
                      color: AppColor.blue,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: w(10)),
                        child: Center(child: SizedBox(child: text(text: widget.tags[index],color: Colors.white,fontsize: 12.sp))),
                      ));
                  }):const SizedBox(),
               

          ],
        )),
  );
}

}