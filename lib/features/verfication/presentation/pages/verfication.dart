import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/home_page/presentation/pages/home_page.dart';
import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';
import 'package:tradpool/features/verfication/presentation/bloc/verfication_bloc.dart';

import '../../../../injection_container.dart';

class Verficiation extends StatefulWidget {
  final String mobile;
  const Verficiation({Key key, this.mobile}) : super(key: key);

  @override
  _VerficiationState createState() => _VerficiationState();
}

class _VerficiationState extends State<Verficiation> {
  TextEditingController textEditingController = TextEditingController();
  String code;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<VerficationBloc>(),
      child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover)),
              child: Center(
                child: Card(
                  child: Container(
                    height: h(280),
                    width: w(350),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: h(20),
                        ),
                        // text(
                        //     text: "Register",
                        //     color: Colors.black,
                        //     fontsize: 20.sp),
                        SizedBox(
                          height: h(20),
                        ),
                        text(
                            text:
                                "An activation code has been sent to your mobile number",
                            color: Colors.green,
                            fontsize: 13.sp),
                        SizedBox(
                          height: h(20),
                        ),
                        Builder(
                          builder: (context) => PinCodeTextField(
                            pinBoxColor: Colors.white,
                            defaultBorderColor: AppColor.grey,
                            controller: textEditingController,
                            maxLength: 6,
                            pinBoxRadius: 4,
                            pinBoxHeight: h(59),
                            pinBoxWidth: w(40),
                            pinBoxOuterPadding:
                                EdgeInsets.symmetric(horizontal: h(10)),
                            hasTextBorderColor: Colors.green,
                            pinTextStyle: TextStyle(
                                color: Colors.green,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold),
                            onDone: (val) {
                              code = val;
                              context.read<VerficationBloc>().add(
                                  ToVerfiyevent("+971" + widget.mobile, code));
                            },
                            onTextChanged: (val) {
                              code = val;
                            },
                          ),
                        ),
                        SizedBox(
                          height: h(15),
                        ),
                        GestureDetector(onTap: (){
                          NetworkFunctions networkFunctions = NetworkFunctionsImp();
                          networkFunctions.postMethod(url: "/tradepool/client/resend-otp?mobileNumber=${"+971" + widget.mobile}",baseurl: "http://159.89.51.204:8080");
                        },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text(
                                  text: "Resend the code",
                                  fontsize: 12.sp,
                                  color: AppColor.hintcolor,
                                  textDecoration: TextDecoration.underline)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h(20),
                        ),
                        BlocConsumer<VerficationBloc, VerficationState>(
                          listener: (context, state) {
                            if (state is VerfiyResponse) {
                              navWithReplaceAll(context, const HomePage());
                            }
                            if (state is Error) {
                              Toast.show(state.error, context, duration: 3,gravity: 2);
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
                                  if (code != null) {
                                    context.read<VerficationBloc>().add(
                                        ToVerfiyevent(widget.mobile, code));
                                  }
                                },
                                child: confirmButton(hint:AppLocalizations.of(context).translate( "Verify")));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ))
              ),
    );
  }
}
