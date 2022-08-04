import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';

import 'package:tradpool/features/subscriptions/page/widgets/subscription_second_step.dart';

import '../../../../App/app.dart';
import '../../../../App/app_localizations.dart';
import '../../../../Core/consts.dart';
import '../../../../Widgets/text.dart';
import '../../../../injection_container.dart';
import '../../../add_auction/presentation/widgets/three_dash.dart';
import '../../../login/presentation/widgets/confirm_button.dart';

class SubscriptionFirstStep extends StatefulWidget {
  final String subscriptionId;
  const SubscriptionFirstStep({Key key, this.subscriptionId}) : super(key: key);

  @override
  State<SubscriptionFirstStep> createState() => _SubscriptionFirstStepState();
}

class _SubscriptionFirstStepState extends State<SubscriptionFirstStep> {
  ImagePicker picker = ImagePicker();
  DateTime datee;
  List<XFile> images = [];
  String logoImageId;
  String commericalRegisterImageId;
  bool isLogo;
  String chosenDate;
  AddItemBloc addItemBloc = sl<AddItemBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            text(text: "Add Subscription"),
            SizedBox(
              height: 50.h,
            ),
            const ThreeDash(
              selected: 1,
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2050),
                    theme: DatePickerTheme(
                        headerColor: AppColor.hintcolor,
                        backgroundColor:
                            const Color.fromARGB(255, 245, 245, 245),
                        itemStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                        doneStyle:
                            TextStyle(color: Colors.white, fontSize: 16.sp)),
                    onChanged: (date) {}, onConfirm: (date) {
        
                  chosenDate = date.toString().substring(0, 10);
                  datee = date;
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: container(
                  hight: h(50),
                  width: w(287),
                  borderRadius: 5,
                  bordercolor: AppColor.grey,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      text(
                          text: chosenDate ?? "Date".toString(),
                          color: AppColor.hintcolor,
                          fontsize: 12.sp),
                    ],
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer(
              bloc: addItemBloc,
              listener: (context, state) {
                  
                                      if (state is AddFileState){
                                        Toast.show ( AppLocalizations.of(context).translate( "Uploaded Successfuly"), context);

                                        if (isLogo) {
                                      
                                          logoImageId = state.addFileResponse[0].id;
                                      
                                        }
                                        else {
                                      
                                          commericalRegisterImageId = state.addFileResponse[0].id;
                                        }
                                      }
                                        
              },
              builder: (context, state) {
                if (state is LoadingFileToUpload){
                  return const Center(child: LoadingState());
                }
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isLogo = false;

                        chooseImage(
                          false,
                          context,
                        );
                      },
                      child: container(
                          hight: h(50),
                          width: w(287),
                          borderRadius: 5,
                          bordercolor: AppColor.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: w(10)),
                                child: text(
                                    text: "Commercial Register",
                                    fontsize: 12.sp,
                                    color: AppColor.hintcolor),
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          )),
                  
             
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                isLogo = true;
                chooseImage(
                  false,
                  context,
                );
              },
              child: container(
                  hight: h(50),
                  width: w(287),
                  borderRadius: 5,
                  bordercolor: AppColor.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w(10)),
                        child: text(
                            text:
                                AppLocalizations.of(context).translate("logo"),
                            fontsize: 12.sp,
                            color: AppColor.hintcolor),
                      ),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  )),
            ),
       
                  ]) ;}),
       
            SizedBox(
              height: 140.h,
            ),
            GestureDetector(
                onTap: () {
                  if (chosenDate != null &&
                      commericalRegisterImageId != null &&
                      logoImageId != null) {
                    nav(
                        context,
                        SubscriptionSecondStep(
                          commericalRegisterImageId: commericalRegisterImageId,
                          logoImageId: logoImageId,
                          subscriptionId: widget.subscriptionId,
                          date: datee.toString(),
                        ));
                  } else {
                    Toast.show(
                        AppLocalizations.of(context).translate(
                            "Please Complete Your Informations first"),
                        context);
                  }
                },
                child: confirmButton(
                    hint: AppLocalizations.of(context).translate('Continue'))),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: confirmButton(
                    hint: AppLocalizations.of(context).translate('Cancel'),
                    color: Colors.grey))
          ],
        ),
      ),
    );
  }

  chooseImage(
    bool iscamera,
    BuildContext context,
  ) async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);

    // source: iscamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedfile != null) {
      addItemBloc.add(UploadFileEvent(
        "file",
        [pickedfile],
      ));

      // return pickedfile;

    } else {
      // print("photo null");
      //  subscriptionsBloc
      //     .add(RequestSubciptionsEvent (  RequestSubscriptionBody(attachments: [Attachment(file: 'file',id: imageId,tag: "boutique_logo")],fromDate: chosenDate.toString(),subscriptionId: subscriptionId)));
    }
  }
}
