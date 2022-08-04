import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';
import 'package:tradpool/features/settings/data/model/update_user_model.dart';
import 'package:tradpool/features/settings/data/model/user_info_response_model.dart';
import 'package:tradpool/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../App/app.dart';
import '../../../../Core/consts.dart';
import '../../../../Widgets/container.dart';
import '../../../../Widgets/text.dart';
import '../../../../Widgets/text_form.dart';
import '../../../../injection_container.dart';
import '../../../login/presentation/widgets/input_container.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserInfoResponseModel userInfoResponseModel = UserInfoResponseModel();
  SettingsBloc settingsBloc = sl<SettingsBloc>();
  TextEditingController mobilec = TextEditingController();
  TextEditingController namec = TextEditingController();
  TextEditingController emailc = TextEditingController();
  TextEditingController addressc = TextEditingController();
  TextEditingController descc = TextEditingController();
  String desc;
  String mobile;
  String name;
  String email;
  String address;
  String prefernec;
  bool checkbox = false;
  UpdateUserBody updateUserModel = UpdateUserBody(id: sl<SharedPreferences>().getString(Con.token));
  @override
  void initState() {
    settingsBloc.add(GetUserInfoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer(
          bloc: settingsBloc,
          listener: (context, state) {
            if (state is Error) {
              Toast.show(state.error, context);
            }
            if (state is UpdateProfileState){
              Toast.show ( AppLocalizations.of(context).translate( 'Added successfully'), context);
              Navigator.of(context).pop()
;            }
          },
          builder: (context, state) {
            if (state is UpdateProfileState) {
              // userInfoResponseModel.name = state.userInfoResponseModel.name;
              // userInfoResponseModel.mobileNumber =
              //     state.userInfoResponseModel.mobileNumber;
              // userInfoResponseModel.email = state.userInfoResponseModel.email;
              // userInfoResponseModel.description =
              //     state.userInfoResponseModel.description;
              // userInfoResponseModel.receiveNotifications =
              //     state.userInfoResponseModel.receiveNotifications;
            }
            if (state is UserInfoState) {
              userInfoResponseModel = state.userInfoResponseModel;
              updateUserModel.attachments = userInfoResponseModel.attachments;
                 updateUserModel.name = userInfoResponseModel.name;
                    updateUserModel.email = userInfoResponseModel.email;
                       updateUserModel.mobileNumber = userInfoResponseModel.mobileNumber;
                          updateUserModel.description = userInfoResponseModel.description;
                        
            }
            if (state is LoadingUserInfo) {
              return const Center(child: LoadingState());
            }
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    container(
                        child: Column(children: [
                      text(
                          text: "Edit Profile",
                          fontsize: 20.sp,
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        height: h(20),
                      ),
                      inputContainer(
                          controller: namec,
                          hint: userInfoResponseModel.name,
                          validation: "name",
                          value: (val) {
                            updateUserModel.name = val;
                            name = val;
                          }),
                      SizedBox(
                        height: h(17),
                      ),
                      container(
                          hight: h(50),
                          width: w(287),
                          borderRadius: 5,
                          bordercolor: AppColor.grey,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: w(10),
                              ),
                              SizedBox(
                                  width: w(40),
                                  child:
                                      text(text: "+971", color: AppColor.blue)),
                              SizedBox(
                                width: w(200),
                                child: textform(
                                  maxlines: 1,
                                  controller: mobilec,
                                  padding: EdgeInsets.all(w(10)),
                                  hintsize: 12.sp,
                                  hint: userInfoResponseModel.mobileNumber,
                                  issecure: false,
                                  validation: "number",
                                  hintColor: AppColor.hintcolor,
                                  function: (val) {
                                    mobile = val;
                                    updateUserModel.mobileNumber = "+971" + val;
                                    log(mobile);
                                  },
                                ),
                              ),
                            ],
                          )),
                      // inputContainer(
                      //     controller: mobilec,
                      //     hint: "Mobile Number",
                      //     validation: "number",
                      //     value: (val) {
                      //       mobile = val;
                      //     }),
                      SizedBox(
                        height: h(17),
                      ),
                      inputContainer(
                        controller: emailc,
                        hint: AppLocalizations.of(context).translate( "Email"),
                        validation: "email",
                        value: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: h(17),
                      ),
                      inputContainer(
                          validation: "name",
                          controller: addressc,
                          hint: userInfoResponseModel.address,
                          value: (val) {
                            address = val;
                          },
                          widget: const Icon(
                            Icons.pin_drop,
                            color: Colors.grey,
                          )),
                      SizedBox(
                        height: h(17),
                      ),
                      inputContainer(
                          hight: h(100),
                          controller: descc,
                          validation: "name",
                          hint: userInfoResponseModel.description,
                          value: (val) {
                            updateUserModel.description = val;
                     
                            desc = val;
                            log(desc);
                          },
                          maxlines: 4,
                          edgeInsetsGeometry: EdgeInsets.symmetric(
                              horizontal: h(10), vertical: w(10))),
                      // SizedBox(
                      //   height: h(17),
                      // ),
                      // inputDrop(
                      //     chosenvalue: prefernec,
                      //     hint: "Select preferences",
                      //     list: ["boutiqe", "company"],
                      //     value: (value) {
                      //       prefernec = value;
                      //     }),
                      SizedBox(
                        height: h(17),
                      ),
                      GestureDetector(
                        onTap: () {},
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
                                      text: "Upload ID",
                                      fontsize: 12.sp,
                                      color: AppColor.hintcolor),
                                ),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            )),
                      ),
                      SizedBox(
                        height: h(5),
                      ),
                      Padding(
                        padding: EdgeInsets.all(w(10.0)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Checkbox(
                              value:
                                  userInfoResponseModel.receiveNotifications ??
                                      false,
                              onChanged: (bool value) {
                                setState(() {
                                  updateUserModel.receiveNotifications = value;
                                  userInfoResponseModel.receiveNotifications =
                                      !userInfoResponseModel
                                          .receiveNotifications;
                                  // checkbox = value;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                text(
                                    text: "receive Notifications",
                                    fontsize: 12.sp),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h(7),
                      )
                    ])),
                    BlocConsumer(
                      bloc: settingsBloc,
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is LoadingUpdateProfile) {
                          return const LoadingState();
                        }

                        return GestureDetector(
                          onTap: () {
                            if (updateUserModel != null) {
                              settingsBloc
                                  .add(UpdateProfileEvent(updateUserModel));
                            }
                          },
                          child: confirmButton(
                              hint:AppLocalizations.of(context).translate( "Confirm"),
                              color: AppColor.blue,
                              width: 250.w),
                        );
                      },
                    )
                  ]),
            );
          },
        ));
  }
}
