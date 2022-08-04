import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:toast/toast.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/core/consts.dart';
import 'package:tradpool/features/add_auction/data/models/auction_body.dart';
import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart';
import 'package:tradpool/features/add_auction/presentation/pages/auction_cost.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/three_dash.dart';
import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';
import 'package:tradpool/features/login/presentation/widgets/input_container.dart';
import '../../../../injection_container.dart';

class AddAuctionThirdPage extends StatefulWidget {
  final AuctionBody auctionBody;
  const AddAuctionThirdPage({Key key, this.auctionBody}) : super(key: key);

  @override
  _AddAuctionThirdPageState createState() => _AddAuctionThirdPageState();
}

class _AddAuctionThirdPageState extends State<AddAuctionThirdPage> {
  int imagecount = 0;
  final ImagePicker picker = ImagePicker();
  bool imagetaken = false;
  XFile image;
  // List<File> images = [];
  List<String> imagesId = [];
  TextEditingController widthc = TextEditingController();
  TextEditingController descc = TextEditingController();
  TextEditingController heightc = TextEditingController();
  TextEditingController weightc = TextEditingController();
  TextEditingController emailOrMobilec = TextEditingController();
  String emailOrMobile;
  bool email = false;
  bool mobile = false;
  String desc;
  String width;
  String heigt;
  String weight;
  bool extraPhoto = false;
  List<XFile> images = <XFile>[];
  String error = 'No Error Dectected';
  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddItemBloc>(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: text(
            text: "Add New Ads",
            color: Colors.black,
            fontsize: 14.sp,
          ),
          centerTitle: true,
          foregroundColor: Colors.grey[50],
          backgroundColor: Colors.grey[50],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: h(54),
                  ),
                  const ThreeDash(
                    selected: 1,
                  ),
                ],
              ),
              SizedBox(
                height: h(30),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(25)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: w(23),
                        ),
                        text(
                            text: "Upload product photos",
                            color: AppColor.hintcolor)
                      ],
                    ),
                    SizedBox(
                      height: h(5),
                    ),
                    Builder(builder: (context) {
                      return BlocConsumer<AddItemBloc, AddItemState>(
                        listener: (context, state) {
                          if (state is AddFileState) {
                            imagecount++;
                            imagetaken = true;
                            images.add(image);
                            for (var i = 0;
                                i < state.addFileResponse.length;
                                i++) {
                              imagesId.add(state.addFileResponse[i].id);
                            }

                            Toast.show(     AppLocalizations.of(context).translate(         "Uploaded Successfully"), context);
                          }
                        },
                        builder: (context, state) {
                          return container(
                              hight: h(50),
                              width: w(287),
                              borderRadius: 5,
                              bordercolor: AppColor.grey,
                              child: GestureDetector(
                                onTap: () {
                                  chooseImage(false, context).then((value) {
                                    var count = value.length;
                                    if (count <= 10 && extraPhoto) {
                                      imagetaken = true;
                                      images = value;
                                      context.read<AddItemBloc>().add(
                                          UploadFileEvent(
                                              "product_image_+$imagecount",
                                              images));
                                    } else if (count >= 10 && extraPhoto) {
                                      images = value.sublist(0, 10);
                                      imagetaken = true;
                                      context.read<AddItemBloc>().add(
                                          UploadFileEvent(
                                              "product_image_+$imagecount",
                                              images));
                                    } else if (count > 10 && !extraPhoto) {
                                      images = value.sublist(0, 5);
                                      imagetaken = true;
                                      context.read<AddItemBloc>().add(
                                          UploadFileEvent(
                                              "product_image_+$imagecount",
                                              images));
                                    } else if (!extraPhoto && count > 5) {
                                      for (var i = 0; i < 5; i++) {
                                        images.add(value[i]);
                                      }
                                      imagetaken = true;
                                      context.read<AddItemBloc>().add(
                                          UploadFileEvent(
                                              "product_image_+$imagecount",
                                              images));
                                    } else if (5 >= count) {
                                      images = value;
                                      imagetaken = true;
                                      context.read<AddItemBloc>().add(
                                          UploadFileEvent(
                                              "product_image_+$imagecount",
                                              images));
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.photo_camera,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: w(7),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      );
                    }),
                    SizedBox(
                      height: h(3),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(20)),
                      child: text(
                          text:
                              "Please try to take the photos from different directions and make sure all photos are with good resolution. This will give you a better chance to sell.",
                          color: AppColor.hintcolor,
                          fontsize: 10.sp),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: w(15),
                        ),
                        SvgPicture.asset("assets/images/questionmark.svg"),
                        Checkbox(
                          fillColor: MaterialStateProperty.all(AppColor.blue),
                          // checkColor: AppColor.blue,
                          value: extraPhoto,
                          onChanged: (bool value) {
                            setState(() {
                              if (value == false) {
                                if (images.isNotEmpty) {
                                  images = [];
                                }
                                imagetaken = false;
                              }
                              extraPhoto = value;
                            });
                          },
                        ),
                        SizedBox(
                          width: w(7),
                        ),
                        text(
                            text: "Upload additional five photos ( 10 AED )",
                            color: AppColor.hintcolor)
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<AddItemBloc, AddItemState>(
                builder: (context, state) {
                  if (state is AddFileState) {
                    imagetaken = true;
                  }
                  return Visibility(
                      visible: imagetaken,
                      child: Column(
                        children: [
                          SizedBox(
                            height: h(20),
                          ),
                          container(
                            width: MediaQuery.of(context).size.width,
                            hight: h(110),
                            child: ListView.builder(
                                itemCount: images.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w(10)),
                                      child: Stack(
                                        children: [
                                          showImage(images[index]),
                                          Positioned(
                                            right: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                images.removeAt(index);
                                                imagesId.removeAt(index);
                                                if (images.isEmpty) {
                                                  imagetaken = false;
                                                }

                                                setState(() {});
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: AppColor.blue,
                                                size: w(20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                          ),
                          SizedBox(
                            height: h(20),
                          ),
                        ],
                      ));
                },
              ),
              Row(
                children: [
                  SizedBox(
                    width: w(45),
                  ),
                  text(
                      text: "Enter product weight and dimensions (Optional)",
                      fontsize: 14.sp,
                      color: AppColor.hintcolor),
                ],
              ),
              SizedBox(
                height: h(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      text(text: "Width"),
                      text(text: "(mm)", fontsize: 10.sp)
                    ],
                  ),
                  inputContainer(
                      width: w(60),
                      textFormWidth: 50,
                      controller: widthc,
                      hint: "",
                      validation: "number",
                      value: (val) {
                        widget.auctionBody.width = double.parse(val);
                        width = val;
                      }),
                  Column(
                    children: [
                      text(text: "Height"),
                      text(text: "(mm)", fontsize: 10.sp)
                    ],
                  ),
                  inputContainer(
                      width: w(60),
                      textFormWidth: 50,
                      controller: heightc,
                      hint: "",
                      validation: "number",
                      value: (val) {
                        widget.auctionBody.height = int.parse(val);
                        heigt = val;
                      }),
                  Column(
                    children: [
                      text(text: "Weight"),
                      text(text: "(kg)", fontsize: 10.sp)
                    ],
                  ),
                  inputContainer(
                      width: w(60),
                      textFormWidth: 50,
                      controller: weightc,
                      hint: "",
                      validation: "number",
                      value: (val) {
                        weight = val;
                      }),
                ],
              ),
              SizedBox(
                height: h(20),
              ),
              Row(
                children: [
                  SizedBox(
                    width: w(45),
                  ),
                  text(
                      text: "Description about the product",
                      fontsize: 14.sp,
                      color: AppColor.hintcolor),
                ],
              ),
              SizedBox(
                height: h(5),
              ),
              inputContainer(
                hight: h(100),
                controller: descc,
                validation: "name",
                hint: AppLocalizations.of(context).translate( "Description"),
                value: (val) {
                  desc = val;
                  widget.auctionBody.description = val;
                },
                maxlines: 4,
              ),
              SizedBox(
                height: h(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.all(AppColor.blue),
                        value: mobile,
                        onChanged: (bool value) {
                          setState(() {
                            mobile = value;
                            widget.auctionBody.shareMobile = value;
                          });
                        },
                      ),
                      text(
                          text: "Share mobile number",
                          color: AppColor.hintcolor)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.all(AppColor.blue),
                        value: email,
                        onChanged: (bool value) {
                          setState(() {
                            widget.auctionBody.shareEmail = value;
                            email = value;
                          });
                        },
                      ),
                      text(text: "Share email", color: AppColor.hintcolor)
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: w(50),
                  ),
                  text(
                      text: "This will be shared with buyer in case of sell",
                      fontsize: 10.sp,
                      color: AppColor.hintcolor),
                ],
              ),
              SizedBox(
                height: h(10),
              ),
              SizedBox(
                height: h(30),
              ),
              Builder(builder: (context) {
                return InkWell(
                    onTap: () {
                      if (imagesId.isNotEmpty &&
                          desc != null &&
                          (email || mobile)) {
                        widget.auctionBody.attachments = imagesIds();

                               context
                            .read<AddItemBloc>()
                            .add(CalculateAuctionEvent(widget.auctionBody));
                        // context
                        //     .read<AddItemBloc>()
                        //     .add(AddAuctionEvent(widget.auctionBody));
                      } 
                      else {
                        Toast.show(     AppLocalizations.of(context).translate(         "Please Complete Your Informations first"), context);
                      }
                    },
                    child: BlocConsumer<AddItemBloc, AddItemState>(
                      listener: (context, state) {
                        if (state is CalculateAuctionState) {
                                   nav(context,  AuctionCost(calculateResponseModel: state.calculateResponseModel,auctionBody: widget.auctionBody,));
                          
                        }
                        if (state is Error) {
                          Toast.show(state.error, context);
                        }
                      },
                      builder: (context, state) {
                        if (state is Loading) {
                          return const LoadingState();
                        }
                        return confirmButton(hint: AppLocalizations.of(context).translate("Calculate Cost"), width: w(250));
                      },
                    ));
              }),
              SizedBox(
                height: h(20),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: confirmButton(
                    hint: AppLocalizations.of(context).translate( "Back"), color: AppColor.hintcolor, width: w(250)),
              ),
              (imagetaken)
                  ? SizedBox(
                      height: h(20),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future<List<XFile>> chooseImage(bool iscamera, BuildContext context) async {
    images = [];
    final pickedfile = await picker.pickMultiImage();

    // source: iscamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedfile != null) {
      return pickedfile;
    } else {
      List<XFile> list = [];
      return list;
    }
  }

  Widget showImage(XFile img) {
    return img != null
        ? container(
            hight: h(150), width: w(150), child: Image.file(File(img.path)))
        : const SizedBox();
  }

  List<Obj> imagesIds() {
    List<Obj> attatchemnts = [];
    for (var i = 0; i < imagesId.length; i++) {
      attatchemnts.add(Obj(id: imagesId[i].toString()));
    }

    return attatchemnts;
  }
}
