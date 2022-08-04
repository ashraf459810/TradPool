import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart'
    as i;
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/settings/presentation/pages/profile.dart';

import '../../../../App/app.dart';
import '../../../../App/app_localizations.dart';

import '../../../../injection_container.dart';
import '../../../add_auction/presentation/widgets/three_dash.dart';
import '../../../login/presentation/widgets/confirm_button.dart';
import '../../bloc/subscriptions_bloc.dart';
import '../../model/request_subscription_body.dart';

class SubscriptionSecondStep extends StatefulWidget {
  final String logoImageId;
  final String commericalRegisterImageId;
  final String subscriptionId;
  final String date;
  const SubscriptionSecondStep(
      {Key key,
      this.logoImageId,
      this.commericalRegisterImageId,
      this.subscriptionId,
      this.date})
      : super(key: key);

  @override
  State<SubscriptionSecondStep> createState() => _SubscriptionSecondStepState();
}

class _SubscriptionSecondStepState extends State<SubscriptionSecondStep> {
  i.AddItemBloc addItemBloc = sl<i.AddItemBloc>();
  SubscriptionsBloc subscriptionsBloc = sl<SubscriptionsBloc>();
  int index = 0;
  List<File> signutresFiles = [File(''), File(''), File('')];
  String signutre1Id;
  String signutre2Id;
  String signutre3Id;

  final SignatureController controller1 = SignatureController(
    penStrokeWidth: 1,
    exportBackgroundColor: AppColor.blue,
    penColor: Colors.black,

    // exportBackgroundColor: Colors.blue,
  );
  final SignatureController controller2 = SignatureController(
    penStrokeWidth: 1,
    exportBackgroundColor: AppColor.blue,
    penColor: Colors.black,

    // exportBackgroundColor: Colors.blue,
  );
  final SignatureController controller3 = SignatureController(
    penStrokeWidth: 1,
    exportBackgroundColor: AppColor.blue,
    penColor: Colors.black,
  );
  List<Signures> signatures = [];

  // exportBac

  @override
  void initState() {

    signatures = [
      Signures(controller1, "1", "signature1"),
      Signures(controller2, "2", "signature2"),
      Signures(controller3, "3", "signature3"),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40.h,
            ),
            text(text: "Add Subscription"),
            SizedBox(
              height: 40.h,
            ),
            const ThreeDash(
              selected: 2,
            ),
            SizedBox(
              height: 80.h,
            ),
            SizedBox(
              height: h(230),
              width: w(300),
              child: BlocConsumer(
                bloc: addItemBloc,
                listener: (context, state) {
   if (state is i.Error) {
                            Toast.show(state.error, context);
                          }
                          if (state is i.AddFileState) {
                            if (index == 0) {
                              signutre1Id = state.addFileResponse[0].id;
                            } else if (index == 1) {
                              signutre2Id = state.addFileResponse[0].id;
                            } else {
                              signutre3Id = state.addFileResponse[0].id;
                            }
                            Toast.show(
                                AppLocalizations.of(context)
                                    .translate("Uploaded Successfully"),
                                context);
                          }
                },
                builder: (context, state) {
                  if (state is i.LoadingFileToUpload){
                    return SizedBox(height: 400.h,width: 300.w,child: const Center(child: LoadingState()),);
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          text(
                              text: signatures[index].text,
                              color: AppColor.hintcolor),
                          IconButton(
                            icon: const Icon(Icons.clear),
                            color: AppColor.blue,
                            onPressed: () async {
                              signatures[index].signatureController.clear();

                              signutresFiles[index] = File('');

                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.check),
                            color: AppColor.blue,
                            onPressed: () async {
                              final Uint8List data = await signatures[index]
                                  .signatureController
                                  .toPngBytes();
                              final tempDir = await getTemporaryDirectory();
                              File file = await File(
                                      '${tempDir.path}/image${DateTime.now()}.png')
                                  .create();
                              file.writeAsBytesSync(data);
                              XFile xFile = XFile(
                                file.path,
                                bytes: data,
                                name: 'file',
                                mimeType: '',
                              );
                              addItemBloc
                                  .add(i.UploadFileEvent("file", [xFile]));
                              signutresFiles.insert(index, file);
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                              onTap: () {
                                if (index != 2) {
                                  index++;
                                }
                                setState(() {});
                              },
                              child: text(text: "Next", color: AppColor.blue)),
                          GestureDetector(
                              onTap: () {
                                if (index != 0) {
                                  index--;
                                }
                                setState(() {});
                              },
                              child:
                                  text(text: "Previous", color: AppColor.blue))
                        ],
                      ),
                      SizedBox(
                        height: 180.h,
                        width: 300.w,
                        child: Signature(
                          width: 300.h,
                          controller: signatures[index].signatureController,
                          height: 180.h,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            signutresFiles.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: signutresFiles[index].path != ''
                          ? Image.file(
                              signutresFiles[index],
                              fit: BoxFit.contain,
                              width: w(200),
                              height: 120.h,
                            )
                          : const SizedBox(),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: 50.h,
            ),
            BlocListener(
              bloc: subscriptionsBloc,
              listener: (context, state) {
                
                if (state is Error) {
                  Toast.show(state.error, context, duration: 4);
                }
                if (state is RequestSubciptionsState) {
                  Toast.show(AppLocalizations.of(context).translate("Request Sent Successfully"), context);
                  navWithReplaceAll(context, const Profile());
                }
              },
              child: GestureDetector(
                  onTap: () {
                    if (controller1.isNotEmpty &&
                        controller2.isNotEmpty &&
                        controller3.isNotEmpty) {
                      subscriptionsBloc.add(RequestSubciptionsEvent(
                          RequestSubscriptionBody(
                              attachments: [
                            Attachment(
                                file: 'file',
                                id: widget.logoImageId,
                                name: 'boutique_logo',
                                tag: 'boutique_logo'),
                            Attachment(
                                file: 'file',
                                id: widget.commericalRegisterImageId,
                                name: 'commerical_Register',
                                tag: 'commerical_Register'),
                            Attachment(
                                file: 'file',
                                id: signutre1Id,
                                name: 'signure1',
                                tag: 'signure1'),
                            Attachment(
                                file: 'file',
                                id: signutre2Id,
                                name: 'signure2',
                                tag: 'signure2'),
                            Attachment(
                                file: 'file',
                                id: signutre3Id,
                                name: 'signure3',
                                tag: 'signure3'),
                          ],
                              fromDate: widget.date.toString(),
                              subscriptionId: widget.subscriptionId)));
                    } else {
                      Toast.show(
                          AppLocalizations.of(context).translate(
                              "please comlete 3 signature and submit them first"),
                          context,
                          duration: 3);
                    }
                  },
                  child: confirmButton(
                      hint:
                          AppLocalizations.of(context).translate('Continue'))),
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
          ],
        ),
      ),
    );
  }
}

class Signures {
  final SignatureController signatureController;
  final String index;
  final String text;

  Signures(this.signatureController, this.index, this.text);
}
