import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/add_auction/data/models/auction_body.dart';
import 'package:tradpool/features/add_auction/data/models/calculate_response_model.dart';
import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart';

import '../../../../App/app.dart';

import '../../../../Widgets/container.dart';
import '../../../../Widgets/nav.dart';
import '../../../../injection_container.dart';
import '../../../login/presentation/widgets/confirm_button.dart';
import '../../../login/presentation/widgets/input_container.dart';
import '../widgets/loading.dart';
import 'auction_placed.dart';

class AuctionCost extends StatefulWidget {
  final CalculateResponseModel calculateResponseModel;
  final AuctionBody auctionBody;
  const AuctionCost({Key key, this.calculateResponseModel, this.auctionBody})
      : super(key: key);

  @override
  State<AuctionCost> createState() => _AuctionCostState();
}

class _AuctionCostState extends State<AuctionCost> {
  TextEditingController addressc = TextEditingController();
  String address;
    List<XFile> images = <XFile>[];
     final ImagePicker picker = ImagePicker();
     AddItemBloc addItemBloc = sl<AddItemBloc>();
     String imagesId ;
  bool canSubmit;
  @override
  void initState() {
    if (widget.calculateResponseModel.addressRequired ||
        widget.calculateResponseModel.idRequired) {
      canSubmit = false;
    }
    else {canSubmit =true;}
    super.initState();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [

            text(text: "Cost Details",fontsize: 30.sp,fontWeight: FontWeight.bold,color: AppColor.hintcolor),
            SizedBox(height: 100.h,),
            widget.calculateResponseModel.remainingAds!=null?            Row(
              children: [
                text(
                    text: "Remaining Ads",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
                text(
                    text:  widget.calculateResponseModel.remainingAds!=null? widget.calculateResponseModel.remainingAds
                        .toString() :"",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
              ],
            ):const SizedBox(),
                  widget.calculateResponseModel.subscriptionType!=null?          Row(
              children: [
                text(
                    text: "subscription Type",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
                text(
                    text: widget.calculateResponseModel.subscriptionType
                      ??'',
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
              ],
            ):const SizedBox(),
       
            Row(
              children: [
                text(
                    text: "Selected Object Ad :",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
                text(
                    text: widget.calculateResponseModel.selectedObjectAd
                        .toString() ,
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
              ],
            ),
              Row(
              children: [
                text(
                    text: "Reservation price :",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
                text(
                    text: widget.calculateResponseModel.reservationPrice
                        .toString(),
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
              ],
            ),
                Row(
              children: [
                text(
                    text: "End time :",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
                text(
                    text: widget.calculateResponseModel.endTime
                        .toString(),
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
              ],
            ),
                     Row(
              children: [
                text(
                    text: "Highlighted AD :",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
                text(
                    text: widget.calculateResponseModel.highlightedAd
                        .toString(),
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
              ],
            ),
            Row(
              children: [
                text(
                    text: "Upload more than five photos :",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
                text(
                    text: widget.calculateResponseModel.uploadMoreThanFivePhotos
                        .toString(),
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
              ],
            ),
                Row(
              children: [
                text(
                    text: "Ad Cost :",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
                text(
                    text: widget.calculateResponseModel.adCost
                        .toString(),
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
              ],
            ),
            SizedBox(height: 40.h,),
                  Row(
              children: [
                text(
                    text: "Total :",
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
                text(
                    text: widget.calculateResponseModel.total
                        .toString(),
                    color: AppColor.blue,
                    fontWeight: FontWeight.bold,
                    fontsize: 16.sp),
              ],
            ),
            SizedBox(height: 100.h,),
    
            BlocConsumer(
              bloc: addItemBloc,
              listener: (context, state) {
                if (state is AddFileState){
                  imagesId = state.addFileResponse[0].id;
                  Toast.show(      AppLocalizations.of(context).translate(        "Uploaded Successfully"), context);
                }
                if (state is AddAuctionState) {
                  navWithReplaceAll(context, const AuctionPlaced());
            
                }
                if (state is Error) {
                  Toast.show(state.error, context);
                }
              },
              builder: (context, state) {
                if (state is LoadingFileToUpload){
                       return const LoadingState();
                }
                if (state is Loading) {
                  return const LoadingState();
                }
                return GestureDetector(
                        onTap: () {
                          if (imagesId !=null && address!=null){
                            canSubmit =true;
                          }
                          if (canSubmit) {
              addItemBloc.add(AddAuctionEvent(widget.auctionBody,imagesId,address));
                            // context
                            //     .read<AddItemBloc>()
                            //     .add(AddAuctionEvent(widget.auctionBody));
                          } else {

                            showbottomsheet();
                       
                          }
                        },
                        child: confirmButton(
                          hint: AppLocalizations.of(context).translate( "submit"),
                          width: w(250),
                        ));
                  
                
              },
            )
          ],
        ),
      ),
    );
  }


showbottomsheet (){
 return showModalBottomSheet<void>(
   isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 400.h,
                color: Colors.grey[50],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 50.h,),
                    text(text: "Please Complete Your Informations first",fontsize: 18.sp,color: AppColor.blue,fontWeight: FontWeight.bold),
                    SizedBox(height: 50.h,),
                  uploadPhoto(),
                  SizedBox(height: 20.w,),

                     Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            inputContainer(
                              hint:AppLocalizations.of(context).translate( "Address"),
                                controller: addressc,
                                validation: "name",
                                maxlines: 1,
                                value: (val) {
                           
                                      
                                  address = val;

                                  
                                }),
                     
                          ],
                        ),
                        SizedBox(height:20.h,),
                      GestureDetector(onTap: (){
                        Navigator.of(context).pop();
                      },
                        child: container(borderRadius: 20,width: 120.w,hight: 50.h,color: AppColor.blue,child: text(text: "Submit",color: Colors.white)))
                  ],
                ),
              );
            },
          );
}

Widget uploadPhoto(){return
container(
                              hight: h(50),
                              width: w(287),
                              borderRadius: 5,
                              bordercolor: AppColor.grey,
                              child: GestureDetector(
                                onTap: () {
                                  chooseImage(false, context).then((value) {
                                  
                                      images.add(value) ;
                                  addItemBloc.add(
                                          UploadFileEvent(
                                              "client_id",
                                              images));
                                    
                                  });
                                },
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      text(text:"Upload ID",color: AppColor.hintcolor,fontsize: 11.sp),
                                      const Icon(
                                        Icons.photo_camera,
                                        color: Colors.grey,
                                      ),
                                     
                                    ],
                                  ),
                                ),
                              ));}
                              
                              
                              
                              Future  chooseImage(bool iscamera, BuildContext context) async {
    images = [];
    final pickedfile = await picker.pickImage(source: ImageSource.gallery,);

    // source: iscamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedfile != null) {
      return pickedfile;
    }
  }
                              }