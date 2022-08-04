import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/core/consts.dart';
import 'package:tradpool/features/add_auction/data/models/auction_body.dart';

import 'package:tradpool/features/add_auction/presentation/pages/add_auction_third_page.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/three_dash.dart';
import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';
import 'package:tradpool/features/login/presentation/widgets/input_container.dart';
import 'package:tradpool/features/register/presentation/widgets/input_drop.dart';

class AddAuctionDetails extends StatefulWidget {
  final bool isFixed;
  final bool isMixed;
  final bool isauction;
  final AuctionBody auctionBody;
  const AddAuctionDetails(
      {Key key, this.isFixed, this.auctionBody, this.isMixed, this.isauction})
      : super(key: key);

  @override
  _AddAuctionDetailsState createState() => _AddAuctionDetailsState();
}

class _AddAuctionDetailsState extends State<AddAuctionDetails> {
  final _formKey = GlobalKey<FormState>();
  bool selectedObjects = false;
  bool highLights = false;
  String reserveationPrice;
  TextEditingController reserveationPricec = TextEditingController();
  TextEditingController startingPricec = TextEditingController();
  String startingPrice;
  bool reservion = false;
  String customerType;
  String deliverType;
  String hour;
  String minute;
  bool endtime = false;
  DateTime dateTime;
  String time;
  String cellperiod;
  String directPrice;
  bool direct = false;
  TextEditingController directPricec = TextEditingController();
  @override
  void initState() {
    widget.auctionBody.highlighted  = highLights;
    widget.auctionBody.selectedObjec = selectedObjects;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Form(
            key: _formKey,
            child: ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: h(54),
                  ),
                  const ThreeDash(
                    selected: 1,
                  ),
                ],
              ),
              (!widget.isFixed || widget.isMixed)
                  ? Column(
                      children: [
                        SizedBox(
                          height: h(20),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: w(23),
                            ),
                            text(
                                text: "Start price", color: AppColor.hintcolor),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            inputContainer(
                                controller: startingPricec,
                                validation: "number",
                                maxlines: 1,
                                value: (val) {
                                  widget.auctionBody.startPrice =
                                      int.parse(val);
                                  startingPrice = val;
                                }),
                            text(text: "AED", fontWeight: FontWeight.bold),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: h(20),
              ),
              Column(
                children: [
                  widget.isauction
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: w(20),
                                ),
                                SvgPicture.asset(
                                    "assets/images/questionmark.svg"),
                                Checkbox(
                                  fillColor:
                                      MaterialStateProperty.all(AppColor.blue),
                                  // checkColor: AppColor.blue,
                                  value: direct,
                                  onChanged: (bool value) {
                                    setState(() {
                                      direct = value;
                                      widget.auctionBody.directSellEnabled =
                                          value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: w(7),
                                ),
                                SizedBox(
                                  height: h(10),
                                ),
                                text(
                                    text: "Direct price",
                                    color: AppColor.hintcolor)
                              ],
                            ),
                            SizedBox(
                              height: h(10),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Visibility(
                    visible: (direct ||
                        widget.isFixed ||
                        (!widget.isauction ||
                            widget.isFixed &&
                            widget.isauction)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: w(23),
                            ),
                            text(
                                text: "Direct price",
                                color: AppColor.hintcolor),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            inputContainer(
                                controller: directPricec,
                                validation: "number",
                                maxlines: 1,
                                hint: "",
                                value: (val) {
                                  directPrice = val;
                                  widget.auctionBody.directSellPrice =
                                      int.parse(val);
                                }),
                            text(text: "AED", fontWeight: FontWeight.bold),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h(20),
                  ),
                ],
              ),
              Visibility(
                visible: (!widget.isFixed || widget.isMixed),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: w(20),
                        ),
                        SvgPicture.asset("assets/images/questionmark.svg"),
                        Checkbox(
                          fillColor: MaterialStateProperty.all(AppColor.blue),
                          // checkColor: AppColor.blue,
                          value: reservion,
                          onChanged: (bool value) {
                            setState(() {
                              reservion = value;
                              // widget.auctionBody.directSellEnabled = value;
                            });
                          },
                        ),
                        SizedBox(
                          width: w(7),
                        ),
                        SizedBox(
                          height: h(10),
                        ),
                        text(
                            text: "Reservion price (10 AED paid)",
                            color: AppColor.hintcolor)
                      ],
                    ),
                    SizedBox(
                      height: h(10),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: reservion,
                child: Column(
                  children: [
                    SizedBox(
                      height: h(20),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: w(25),
                        ),
                        text(
                            text: "Enter Reservation price",
                            color: AppColor.hintcolor)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        inputContainer(
                            controller: reserveationPricec,
                            validation: "number",
                            maxlines: 1,
                            value: (val) {
                              reserveationPrice = val;
                              widget.auctionBody.directSellPrice =
                                  int.parse(val);
                            }),
                        text(text: "AED", fontWeight: FontWeight.bold),
                      ],
                    ),
                    SizedBox(
                      height: h(20),
                    ),
                  ],
                ),
              ),
              !widget.isFixed && widget.isMixed
                  ? SizedBox(
                      height: h(20),
                    )
                  : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: w(23),
                  ),
                  text(text: "Sell period", color: AppColor.hintcolor)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  inputDrop(
                    chosenvalue: cellperiod,
                    hint: "",
                    list: [
                      "1",
                      "2",
                      "3",
                      "4",
                      "5",
                      "6",
                      "7",
                      "8",
                      "9",
                      "10",
                      "11",
                      "12",
                      "13",
                      "14"
                    ],
                    value: (val) {
                      cellperiod = val;
                      widget.auctionBody.days = int.parse(val);
                    },
                  ),
                  text(text: "Days", fontWeight: FontWeight.bold),
                ],
              ),

              Row(
                children: [
                  SizedBox(
                    width: w(20),
                  ),
                  SvgPicture.asset("assets/images/questionmark.svg"),
                  Checkbox(
                    fillColor: MaterialStateProperty.all(AppColor.blue),
                    // checkColor: AppColor.blue,
                    value: highLights,
                    onChanged: (bool value) {
                      setState(() {
                        widget.auctionBody.highlighted = value;
                        highLights = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: w(7),
                  ),
                  text(text: "Highlighted ADS", color: AppColor.hintcolor),
                ],
              ),
              SizedBox(
                height: h(20),
              ),

              Row(
                children: [
                  SizedBox(
                    width: w(20),
                  ),
                  SvgPicture.asset("assets/images/questionmark.svg"),
                  Checkbox(
                    fillColor: MaterialStateProperty.all(AppColor.blue),
                    // checkColor: AppColor.blue,
                    value: selectedObjects,
                    onChanged: (bool value) {
                      setState(() {
                        selectedObjects = value;
                        widget.auctionBody.selectedObjec = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: w(7),
                  ),
                  text(text: "Selected object ADS", color: AppColor.hintcolor),
                ],
              ),
              SizedBox(
                height: h(20),
              ),
              Row(
                children: [
                  SizedBox(
                    width: w(20),
                  ),
                  SvgPicture.asset("assets/images/questionmark.svg"),
                  Checkbox(
                    fillColor: MaterialStateProperty.all(AppColor.blue),
                    // checkColor: AppColor.blue,
                    value: endtime,
                    onChanged: (bool value) {
                      setState(() {
                        endtime = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: w(7),
                  ),
                  text(
                      text: "end time (10 AED paid)",
                      color: AppColor.hintcolor),
                ],
              ),
              Visibility(
                visible: endtime,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          DatePicker.showTime12hPicker(context,
                              theme: DatePickerTheme(
                                  doneStyle: TextStyle(color: AppColor.blue)),
                              showTitleActions: true,
                              onChanged: (date) {}, onConfirm: (date) {
                            dateTime = date;
                            widget.auctionBody.hourOfEnd = date.hour;

                            widget.auctionBody.minuteOfEnd = date.minute;
                            time = DateFormat("h:mm:a").format(date);
                            setState(() {});
                          }, currentTime: DateTime.now());
                        },
                        child: container(
                          width: w(200),
                          hight: h(30),
                          borderRadius: 5,
                          color: Colors.white,
                          child: Text(
                            time ?? 'End Time',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColor.blue),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: h(10),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      endtime
                          ? SizedBox(
                              width: w(3),
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: w(23),
                      ),
                      text(text: "Deliver Type", color: AppColor.hintcolor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: w(23),
                      ),
                      inputDrop(
                        chosenvalue: deliverType,
                        hint: "",
                        list: [AppLocalizations.of(context).translate("SHIPPING"),AppLocalizations.of(context).translate( "HAND_BY_HAND")],
                        value: (val) {
                     
                          deliverType = val;

                      if (val=="HAND_BY_HAND" || val =="باليد"){
                          widget.auctionBody.deliverType =  "HAND_BY_HAND";
                                                }
                                                else {
                                                  widget.auctionBody.deliverType = "SHIPPING";
                                                }
                                             
                                                                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  deliverType != "HAND_BY_HAND" && deliverType!="باليد"
                      ? Column(
                          children: [
                            SizedBox(
                              height: h(20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: w(23),
                                ),
                                inputDrop(
                                  chosenvalue: deliverType,
                                  hint: "",
                                  list: [AppLocalizations.of(context).translate( "SELLER"),AppLocalizations.of(context).translate( "BUYER")],
                                  value: (val) {
                                  
                                    customerType = val;
                                    widget.auctionBody.shippingPayer = val;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox(),
                  (deliverType == "SHIPPING" && customerType == "SELLER")
                      ? Column(
                          children: [
                            SizedBox(
                              height: h(30),
                            ),
                            SizedBox(
                              height: h(30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset("assets/images/dhl.png"),
                                  Image.asset("assets/images/aramex.png")
                                ],
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: h(40),
                  ),
                  InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {}
                        if (widget.isMixed == true) {
                          if (startingPrice != null &&
                              cellperiod != null &&
                              deliverType != null &&
                              (deliverType == "HAND_BY_HAND" ||  deliverType == "باليد" ||
                                  customerType != null)) {
                            widget.auctionBody.hourOfEnd = DateTime.now().hour;
                            widget.auctionBody.minuteOfEnd =
                                DateTime.now().minute;

                            nav(
                                context,
                                AddAuctionThirdPage(
                                    auctionBody: widget.auctionBody));
                          } else {
                            Toast.show(
                             AppLocalizations.of(context).translate(   "Please Complete Your Informations first"), context);
                          }
                        } else if (widget.isFixed == true) {
                          
                          if (cellperiod != null &&
                              deliverType != null &&
                              (deliverType == "HAND_BY_HAND" || deliverType == "باليد" ||
                                  customerType != null)) {
                            widget.auctionBody.hourOfEnd = DateTime.now().hour;
                            widget.auctionBody.minuteOfEnd =
                                DateTime.now().minute;
                            nav(
                                context,
                                AddAuctionThirdPage(
                                    auctionBody: widget.auctionBody));
                          } else {
                       
                            Toast.show(
                  AppLocalizations.of(context).translate(            "Please Complete Your Informations first"), context);
                          }
                        } else if (widget.isFixed == false) {
                          if (startingPrice != null &&
                              cellperiod != null &&
                              deliverType != null &&
                              (deliverType == "HAND_BY_HAND" ||  deliverType == "باليد" ||
                                  customerType != null)) {
                            widget.auctionBody.hourOfEnd = DateTime.now().hour;
                            widget.auctionBody.minuteOfEnd =
                                DateTime.now().minute;
                            nav(
                                context,
                                AddAuctionThirdPage(
                                    auctionBody: widget.auctionBody));
                          } else {
                            Toast.show(     AppLocalizations.of(context).translate(        
"Please Complete Your Informations first"), context);
                          }
                        }
                      },
                      child: confirmButton(hint: "Continue", width: w(250))),
                  SizedBox(
                    height: h(20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: confirmButton(
                        hint: "Back", color: AppColor.hintcolor, width: w(250)),
                  ),
                ],
              ),
              SizedBox(
                height: h(20),
              )
            ])));
  }
}
