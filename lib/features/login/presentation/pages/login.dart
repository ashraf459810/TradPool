import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/Widgets/text_form.dart';

import 'package:tradpool/features/login/presentation/bloc/log_in_bloc.dart';

import 'package:tradpool/features/login/presentation/widgets/confirm_button.dart';

import 'package:tradpool/features/register/presentation/pages/register.dart';
import 'package:tradpool/features/verfication/presentation/pages/verfication.dart';

import '../../../../injection_container.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mobilec = TextEditingController();
  String mobile;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LogInBloc>(),
      child: Scaffold(
          body: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover)),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: container(
                          hight: h(250),
                          width: w(320),
                          color: Colors.white,
                          borderRadius: 10,
                          child: Column(
                            children: [
                              SizedBox(
                                height: h(20),
                              ),
                              text(
                                  text: "Login",
                                  fontsize: 20.sp,
                                  fontWeight: FontWeight.w400),
                              SizedBox(
                                height: h(20),
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
                                          hint: AppLocalizations.of(context).translate("Mobile Number"),
                                          issecure: false,
                                          validation: "number",
                                          hintColor: AppColor.hintcolor,
                                          function: (val) {
                                            mobile = val;
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: h(20),
                              ),
                              BlocConsumer<LogInBloc, LogInState>(
                                listener: (context, state) {
                                  if (state is Error) {
                                    Toast.show(state.error, context,gravity: 2);
                                  }
                                  if (state is LoginResponse) {
                                    //  Toast.show(state.error, context);
                                    nav(
                                        context,
                                        Verficiation(
                                          mobile: mobile,
                                        ));
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
                                        context
                                            .read<LogInBloc>()
                                            .add(ToLoginEvent("+971" + mobile));
                                      },
                                      child: confirmButton(hint: "Continue"));
                                },
                              ),
                              SizedBox(
                                height: h(20),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text(
                                      text: "Don't have an account? ",
                                      color: AppColor.hintcolor),
                                  InkWell(
                                      onTap: () {
                                        nav(context, const Register());
                                      },
                                      child: text(
                                          text: "Register",
                                          color: AppColor.blue))
                                ],
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ))),
    );
  }
}
