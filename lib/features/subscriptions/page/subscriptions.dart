import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart'
    as a;
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/subscriptions/bloc/subscriptions_bloc.dart';
import 'package:tradpool/features/subscriptions/model/my_subscription_model.dart';
import 'package:tradpool/features/subscriptions/model/request_subscription_body.dart';
import 'package:tradpool/features/subscriptions/model/subscriptions_model.dart';

import 'package:tradpool/features/subscriptions/page/widgets/subscription_zero_step.dart';

import '../../../App/app.dart';
import '../../../Widgets/default_app_bar.dart';
import '../../../injection_container.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key key}) : super(key: key);

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  final ImagePicker picker = ImagePicker();
  a.AddItemBloc addItemBloc = sl<a.AddItemBloc>();
  bool isSubscription = true;
  SubscriptionsResponseModel subscriptionsResponseModel =
      SubscriptionsResponseModel(content: []);
  MySubscriptionResponseModel mySubscriptionResponseModel =
      MySubscriptionResponseModel(content: []);
  SubscriptionsBloc subscriptionsBloc = sl<SubscriptionsBloc>();
  String imageId;
  String subscriptionId;
  DateTime chosenDate;
  @override
  void initState() {
    subscriptionsBloc.add(GetSubcriptionsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  FloatingActionButton(backgroundColor: AppColor.blue,foregroundColor: AppColor.blue,child: const Icon(Icons.add,color: Colors.white ,),
        onPressed: () { 
      if(  subscriptionsResponseModel.content.isNotEmpty) {
        nav(context, SubscriptionZeroStep(subscriptionsResponseModel: subscriptionsResponseModel,));
      } },),
        body: BlocConsumer(
      bloc: subscriptionsBloc,
      listener: (context, state) {
        if (state is GetSubscriptionsPaymentsState) {
          Toast.show(
              AppLocalizations.of(context)
                  .translate("Request Sent Successfully"),
              context);
        }
        if (state is Error) {
          Toast.show(state.error, context, duration: 4);
        }
        if (state is RequestSubciptionsState) {
          Toast.show(
              AppLocalizations.of(context)
                  .translate("Request Sent Successfully"),
              context);
        }
      },
      builder: (context, state) {
        if (state is LoadingMySubscriptionState){
                       return const Center(child: LoadingState());    
        }
        if (state is SubscriptionsInitial){
                 return const Center(child: LoadingState());
        }
        if (state is MySubscriptionState) {
          mySubscriptionResponseModel = state.mySubscriptionResponseModel;
     
        }
        if (state is LoadingSubscriptions) {
          return const Center(child: LoadingState());
        }
        if (state is GetSubscriptionsState) {
          subscriptionsResponseModel = state.subscriptionsResponseModel;
          subscriptionsBloc.add(GetMySubscriptionEvent());
        }
    //     return ListView(
    //             children: [
    //               SizedBox(
    //                   height: h(40),
    //                   width: w(300),
    //                   child: const DefaultAppBar()),
    //               SizedBox(
    //                 height: 20.h,
    //               ),
    //               // Row(
    //               //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               //   children: [
    //               //     GestureDetector(
    //               //         onTap: () {
    //               //           isSubscription = true;
    //               //           setState(() {});
    //               //         },
    //               //         child: container(
    //               //             color: Colors.white,
    //               //             hight: 40.h,
    //               //             width: 120.w,
    //               //             borderRadius: 20,
    //               //             child: Text(
    //               //               AppLocalizations.of(context)
    //               //                   .translate("Request Subscription"),
    //               //               style: TextStyle(
    //               //                   color: isSubscription
    //               //                       ? AppColor.blue
    //               //                       : AppColor.hintcolor,
    //               //                   fontSize: 12.sp),
    //               //             ))),
    //               //     GestureDetector(
    //               //         onTap: () {
    //               //           isSubscription = false;
    //               //           setState(() {});
    //               //         },
    //               //         child: container(
    //               //             color: Colors.white,
    //               //             hight: 40.h,
    //               //             width: 120.w,
    //               //             borderRadius: 20,
    //               //             child: Text(
    //               //               AppLocalizations.of(context)
    //               //                   .translate("My Subscription"),
    //               //               style: TextStyle(
    //               //                   color: !isSubscription
    //               //                       ? AppColor.blue
    //               //                       : AppColor.hintcolor,
    //               //                   fontSize: 12.sp),
    //               //             ))),
    //               //   ],
    //               // ),
          


    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: container(
    //                   borderRadius: 10,
    //                   hight: 50.h,
    //                   color: AppColor.blue,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Text(
    //                         AppLocalizations.of(context).translate("Type"),
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 18.sp),
    //                       ),
    //                       Text(
    //                           AppLocalizations.of(context)
    //                               .translate("Month No."),
    //                           style: TextStyle(
    //                               color: Colors.white,
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 18.sp)),
    //                       Text(
    //                         AppLocalizations.of(context).translate("Cost(AED)"),
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 18.sp),
    //                       ),

                       
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: container(
    //                       borderRadius: 10,
    //                       color: Colors.white,
    //                       child: subscriptionsResponseModel.content.isNotEmpty
    //                           ? ListView.builder(
    //                               shrinkWrap: true,
    //                               itemCount:
    //                                   subscriptionsResponseModel.content.length,
    //                               // ignore: void_checks
    //                               itemBuilder: (context, index) =>
    //                                   GestureDetector(
    //                                 onTap: () {
    //                                   nav(
    //                                       context,
    //                                       SubscriptionFirstStep(
    //                                         subscriptionId:
    //                                             subscriptionsResponseModel
    //                                                 .content[index]
    //                                                 .subscriptionId,
    //                                       ));
    //                                   // DatePicker.showDatePicker(context,
    //                                 },
    //                                 child: Padding(
    //                                   padding:
    //                                       EdgeInsets.symmetric(vertical: 10.h),
    //                                   child: GestureDetector(
    //                                     child: Row(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.start,
    //                                         children: [
    //                                           SizedBox(
    //                                             width: 20.w,
    //                                           ),
    //                                           Text(
    //                                               subscriptionsResponseModel
    //                                                   .content[index].type,
    //                                               style: TextStyle(
    //                                                   color: Colors.black,
    //                                                   fontWeight:
    //                                                       FontWeight.bold,
    //                                                   fontSize: 12.sp)),
    //                                           SizedBox(
    //                                             width: 20.w,
    //                                           ),
    //                                           SizedBox(
    //                                             width: 50.w,
    //                                             child: Text(
    //                                                 subscriptionsResponseModel
    //                                                     .content[index]
    //                                                     .monthlyAdsCount
    //                                                     .toString(),
    //                                                 textAlign: TextAlign.end,
    //                                                 style: TextStyle(
    //                                                     color: Colors.black,
    //                                                     fontWeight:
    //                                                         FontWeight.bold,
    //                                                     fontSize: 12.sp)),
    //                                           ),
    //                                           SizedBox(
    //                                             width: 60.w,
    //                                           ),
    //                                           SizedBox(
    //                                             width: 80.w,
    //                                             child: Text(
    //                                                 subscriptionsResponseModel
    //                                                     .content[index]
    //                                                     .monthlyCost
    //                                                     .toString(),
    //                                                 textAlign: TextAlign.end,
    //                                                 style: TextStyle(
    //                                                     color: Colors.black,
    //                                                     fontWeight:
    //                                                         FontWeight.bold,
    //                                                     fontSize: 12.sp)),
    //                                           ),
    //                                           SizedBox(
    //                                             width: 20.w,
    //                                           ),
    //                                              GestureDetector(
    //                                               onTap: (){
    //                                                 showModalBottomSheet(
    // context: context,
    // builder: (context) {
    //   return Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
    //          children: [
    //            Text(
    //                             AppLocalizations.of(context).translate("FromDate"),
    //                             style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold,
    //                                 fontSize: 11.sp),
    //                           ),
                              
    //          ],
    //        ),
    //     ],
    //   );
    // });
    //                                               },
    //                                               child: text(text: "Details",fontWeight: FontWeight.bold,color: AppColor.blue))
    //                                           // Text(
    //                                           //   AppLocalizations.of(context)
    //                                           //       .translate("Request"),
    //                                           //   textAlign: TextAlign.end,
    //                                           //   style: const TextStyle(
    //                                           //       color: Colors.white,
    //                                           //       fontWeight: FontWeight.bold,
    //                                           //       fontSize: 12),
    //                                           // )
    //                                         ]),
    //                                   ),
    //                                 ),
    //                               ),
    //                             )
    //                           : Center(
    //                               child: Text(
    //                                   AppLocalizations.of(context)
    //                                       .translate("No Packages For Now"),
    //                                   style: TextStyle(
    //                                       color: AppColor.blue,
    //                                       fontWeight: FontWeight.bold,
    //                                       fontSize: 15.sp)),
    //                             ))),
    //             ],
    //           );
            return ListView(
                children: [
                  SizedBox(
                      height: h(40),
                      width: w(300),
                      child: const DefaultAppBar()),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             isSubscription = true;
                  //           });
                  //         },
                  //         child: container(
                  //             color: Colors.white,
                  //             hight: 40.h,
                  //             width: 120.w,
                  //             borderRadius: 20,
                  //             child: Text(
                  //               AppLocalizations.of(context)
                  //                   .translate("Request Subscription"),
                  //               style: TextStyle(
                  //                   color: isSubscription
                  //                       ? AppColor.blue
                  //                       : AppColor.hintcolor,
                  //                   fontSize: 12.sp),
                  //             ))),
                  //     GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             isSubscription = false;
                  //           });
                  //         },
                  //         child: container(
                  //             color: Colors.white,
                  //             hight: 40.h,
                  //             width: 120.w,
                  //             borderRadius: 20,
                  //             child: Text(
                  //               AppLocalizations.of(context)
                  //                   .translate("My Subscription"),
                  //               style: TextStyle(
                  //                   color: !isSubscription
                  //                       ? AppColor.blue
                  //                       : AppColor.hintcolor,
                  //                   fontSize: 12.sp),
                  //             ))),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: container(
                      borderRadius: 10,
                      hight: 50.h,
                      color: AppColor.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate("FromDate"),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp),
                          ),
                          Text(AppLocalizations.of(context).translate("ToDate"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp)),
                          Text(
                            AppLocalizations.of(context).translate("Status"),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp),
                          ),
                          Text(
                              AppLocalizations.of(context)
                                  .translate("Ads Count"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp)),
                          Text(
                              AppLocalizations.of(context)
                                  .translate("Remaining Ads"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp)),
                          Text(
                            AppLocalizations.of(context).translate("Cost(AED)"),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: container(
                          borderRadius: 10,
                          color: Colors.grey,
                          child: mySubscriptionResponseModel.content.isNotEmpty  && state is! LoadingMySubscriptionState
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: mySubscriptionResponseModel
                                      .content.length,
                                  // subscriptionsResponseModel.content.length,
                                  // ignore: void_checks
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: GestureDetector(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                  mySubscriptionResponseModel
                                                      .content[index].fromDate
                                                      .toString()
                                                      .substring(0, 10),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 9.sp)),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                  mySubscriptionResponseModel
                                                      .content[index].toDate
                                                      .toString()
                                                      .substring(0, 10),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 9.sp)),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (mySubscriptionResponseModel
                                                          .content[index].status
                                                          .toString() ==
                                                      "SUCCESSFUL") {
                                                    subscriptionsBloc.add(
                                                        GetSubscriptionsPaymentsEvent(
                                                            mySubscriptionResponseModel
                                                                .content[index]
                                                                .subscriptionActivationId,
                                                            mySubscriptionResponseModel
                                                                .content[index]
                                                                .fromDate
                                                                .toString(),
                                                            mySubscriptionResponseModel
                                                                .content[index]
                                                                .toDate
                                                                .toString(),
                                                            "SUCCESSFUL"));
                                                  }
                                                },
                                                child: SizedBox(
                                                  width: 40.w,
                                                  child: Text(
                                                      mySubscriptionResponseModel
                                                                  .content[index]
                                                                  .status
                                                                  .toString() ==
                                                              "SUCCESSFUL"
                                                          ? AppLocalizations.of(
                                                                  context)
                                                              .translate("Pay")
                                                          : mySubscriptionResponseModel
                                                              .content[index]
                                                              .status
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 8.sp)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              SizedBox(
                                                width: 40.w,
                                             
                                                child: Text(
                                                    mySubscriptionResponseModel
                                                        .content[index]
                                                        .monthlyAdsCount
                                                        .toString(),
                                                       
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.sp)),
                                              ),
                                              SizedBox(
                                                width: 35.w,
                                              ),
                                     mySubscriptionResponseModel
                                                      .content[index]
                                                      .payments.isNotEmpty?           Text(
                                                  mySubscriptionResponseModel
                                                      .content[index]
                                                      .payments[0]
                                                      .remainingAds
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.sp)):text(text: "-",color: Colors.white),
                                              SizedBox(
                                                width: 55.w,
                                              ),
                                              Text(
                                                  mySubscriptionResponseModel
                                                      .content[index]
                                                      .monthlyCost
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.sp)),
                                            ]),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: SizedBox(

                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate("No Requests For You Now"),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp)),
                                  ),
                                ))),
                ],
              );
     
     
      },
    ));
  }

  chooseImage(bool iscamera, BuildContext context) async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);

    // source: iscamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedfile != null) {
   
      addItemBloc.add(a.UploadFileEvent("file", [pickedfile]));

      // return pickedfile;

    } else {
   
      subscriptionsBloc.add(RequestSubciptionsEvent(RequestSubscriptionBody(
          attachments: [
            Attachment(file: 'file', id: imageId, tag: "boutique_logo")
          ],
          fromDate: chosenDate.toString(),
          subscriptionId: subscriptionId)));
    }
  }
}
