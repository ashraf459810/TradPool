// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/Widgets/text_form.dart';
import 'package:tradpool/features/Register/presentation/bloc/register_bloc.dart';

import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';
import 'package:tradpool/features/login/presentation/widgets/input_container.dart';
import 'package:tradpool/features/register/data/models/create_user.dart';

import 'package:tradpool/features/verfication/presentation/pages/verfication.dart';

import 'package:tradpool/injection_container.dart';

import '../../../add_auction/presentation/bloc/add_item_bloc.dart' as p;

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
    final formKey = GlobalKey<FormState>();
  List<XFile> images = <XFile>[];
  final ImagePicker picker = ImagePicker();
  p.AddItemBloc addItemBloc = sl<p.AddItemBloc>();
  String imagesId;
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

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => sl<RegisterBloc>(),
      child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover)),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: h(40),
                      ),
                      Card(
                        child: container(
                            hight: h(720),
                            width: w(320),
                            color: Colors.white,
                            borderRadius: 10,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: h(20),
                                ),
                                text(
                                    text: "Register",
                                    fontsize: 20.sp,
                                    fontWeight: FontWeight.w400),
                                SizedBox(
                                  height: h(20),
                                ),
                                inputContainer(
                                    controller: namec,
                                    hint:AppLocalizations.of(context).translate( "Name"),
                                    validation: "name",
                                    value: (val) {
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
                                            child: text(
                                                text: "+971",
                                                color: AppColor.blue)),
                                        SizedBox(
                                          width: w(200),
                                          child: textform(
                                            maxlines: 1,
                                            controller: mobilec,
                                            padding: EdgeInsets.all(w(10)),
                                            hintsize: 12.sp,
                                            hint: AppLocalizations.of(context).translate( "Mobile Number"),
                                            issecure: false,
                                            validation: "number",
                                            hintColor: AppColor.hintcolor,
                                            function: (val) {
                                              mobile = val;
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
                                Form(
                                  key: formKey,
                                  child: inputContainer(
                                    controller: emailc,
                                    hint: AppLocalizations.of(context).translate( "Email"),
                                    validation: "email",
                                    value: (val) {
                                      email = val;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: h(17),
                                ),
                                inputContainer(
                                    validation: "name",
                                    controller: addressc,
                                    hint: AppLocalizations.of(context).translate( "Address"),
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
                                    hint:AppLocalizations.of(context).translate(  "Description"),
                                    value: (val) {
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
                                  onTap: () {
                                    chooseImage(false, context).then((value) {
                                      images.add(value);
                                      addItemBloc.add(p.UploadFileEvent(
                                          "client_id", images));
                                    });
                                  },
                                  child:
                                      BlocListener(
                                        bloc: addItemBloc,
                                    listener: (context, state) {
                                  if (state is p.AddFileState){
                                    Toast.show ( AppLocalizations.of(context).translate( "Uploaded Successfuly"), context,gravity: 2);
                                    imagesId = state.addFileResponse[0].id;
                                  }
                                    },
                                    child: container(
                                        hight: h(50),
                                        width: w(287),
                                        borderRadius: 5,
                                        bordercolor: AppColor.grey,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: w(10)),
                                              child: text(
                                                  text: AppLocalizations.of(context).translate(  "Upload ID"),
                                                  fontsize: 12.sp,
                                                  color: AppColor.hintcolor),
                                            ),
                                            const Icon(Icons.arrow_drop_down)
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: h(5),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(w(3.0)),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: checkbox,
                                        onChanged: (bool value) {
                                          setState(() {
                                            checkbox = value;
                                          });
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          text(
                                              text:
                                                  "I have read and agree to the ",
                                              fontsize: 12.sp),
                                          text(
                                              textDecoration:
                                                  TextDecoration.underline,
                                              text: "Terms & Conditions",
                                              fontsize: 12.sp)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: h(7),
                                ),
                                BlocConsumer<RegisterBloc, RegisterState>(
                                  listener: (context, state) {
                                    if (state is Error) {
                                      Toast.show(state.error, context,gravity: 2);
                                    }
                                    if (state is RegisterResponse) {
                                      //  Toast.show(state.error, context);
                                      nav(context,
                                          Verficiation(mobile: mobile));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is Loading) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: AppColor.blue,
                                          color: Colors.white,
                                        ),
                                      );
                                    }

                                    return InkWell(
                                        onTap: () {
                                          if (checkbox&& formKey.currentState.validate()) {
                                            context.read<RegisterBloc>().add(
                                                ToRegisterEvent(CreateUserModel(
                                                  
                                                    addressmodel: address,
                                                    descriptionmodel: desc,
                                                    emailmodel: email,
                                                    mobileNumbermodel:
                                                        "+971" + mobile,
                                                    namemodel: name,
                                                    receiveNotificationsmodel:
                                                        checkbox)));
                                          } else {
                                            Toast.show(
                                                "please agree on terms and conditions",
                                                context,gravity: 2);
                                          }
                                        },
                                        child: confirmButton(hint: "Register"));
                                  },
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }

  Future chooseImage(bool iscamera, BuildContext context) async {
    images = [];
    final pickedfile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    // source: iscamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedfile != null) {
      return pickedfile;
    }
  }
}
