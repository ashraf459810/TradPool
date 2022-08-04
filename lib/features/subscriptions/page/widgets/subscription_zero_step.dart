import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/features/subscriptions/model/subscriptions_model.dart';
import 'package:tradpool/features/subscriptions/page/widgets/subscription_first_step.dart';

import '../../../../App/app_localizations.dart';
import '../../../../Widgets/text.dart';
import '../../../add_auction/presentation/widgets/three_dash.dart';
import '../../../login/presentation/widgets/confirm_button.dart';

class SubscriptionZeroStep extends StatefulWidget {
  final SubscriptionsResponseModel subscriptionsResponseModel;
  const SubscriptionZeroStep({Key key, this.subscriptionsResponseModel}) : super(key: key);

  @override
  State<SubscriptionZeroStep> createState() => _SubscriptionZeroStepState();
}

class _SubscriptionZeroStepState extends State<SubscriptionZeroStep> {
  int chosenIndex = -1;
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Column(
         
          children: [
            SizedBox(
              height: 50.h,
            ),
            text(text: "Add Subscription"),
            SizedBox(
              height: 50.h,
            ),
           const  ThreeDash(
              selected: 0,
            ),
            SizedBox(height: 20.h,),
            GridView.builder( 
              shrinkWrap: true,
              itemCount: widget.subscriptionsResponseModel.content.length,
                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 10), itemBuilder: (BuildContext context, int index) { 
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(onTap: (){
                    chosenIndex =index;
                    setState(() {
                      
                    });

                  },
                    child: container(color: Colors.white,hight: 80.h,width: 200.w,borderRadius: 10,
                    bordercolor: chosenIndex==index? AppColor.blue:Colors.transparent,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                                   text(text:     widget.subscriptionsResponseModel.content[index].name),
                                    text(text:     widget.subscriptionsResponseModel.content[index].type),
                                                   Row(
                                                     children: [
                                                    
                                                       text(text:     widget.subscriptionsResponseModel.content[index].monthlyAdsCount.toString(),color: AppColor.blue),
                                                       text(text: " "),
                                                       text(text: "Ads Count",fontsize: 12.sp), text(text: " "),   text(text: "For",fontsize: 12.sp),
                                                       text(text: " "),
                                                       text(text:  widget.subscriptionsResponseModel.content[index].periodInMonths.toString(),color: AppColor.blue),
                                                       text(text: " "),
                                                       text(text: "Month",fontsize: 12.sp),
                                                            
                                                     ],
                                                   ),
                                                      Row(
                                                        children: [
                                                          text(text:  widget.subscriptionsResponseModel.content[index].monthlyCost.toString(),color: AppColor.blue),
                                                          text(text: ' '),
                                                          text(text: "AED")
                                                        ],
                                                      ),
                                                      
                          
                  
                  
                                        
                                   
                        ],),
                      ),
                    ) ),
                  ),
                );
               },  ),
                                               SizedBox(height: 50.h,),       
               GestureDetector(onTap: (){
                if (chosenIndex!=-1){
                  nav(context, SubscriptionFirstStep(subscriptionId: widget.subscriptionsResponseModel.content[chosenIndex].subscriptionId,));
                }
               },
                 child: confirmButton(
                        hint:
                            AppLocalizations.of(context).translate('Continue')),
               ),
            
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: confirmButton(
                  hint: AppLocalizations.of(context).translate('Cancel'),
                  color: Colors.grey),
            )
                     
      ],),
    );
  }
}