import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/custom_list_view.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/settings/data/model/support_user_request_model.dart';
import 'package:tradpool/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tradpool/features/settings/presentation/widgets/support_request_details.dart';

import '../../../../App/app.dart';
import '../../../../Widgets/container.dart';
import '../../../../injection_container.dart';

class SupportRequests extends StatefulWidget {
  const SupportRequests({Key key}) : super(key: key);

  @override
  State<SupportRequests> createState() => _SupportRequestsState();
}

class _SupportRequestsState extends State<SupportRequests> {
  SettingsBloc settingsBloc = sl<SettingsBloc>();
  SupportRequestModel supportRequestModel = SupportRequestModel(content: []);


  @override
  void initState() {
  settingsBloc.add( const SupportRequestEvent("0", "1000"));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: [
        SizedBox(
          height: h(20),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            container(
              hight: h(36),
              width: w(36),
              color: Colors.white,
              child: const Center(
                  child: Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              )),
            ),
            SvgPicture.asset(
              "assets/images/logo.svg",
              fit: BoxFit.contain,
            ),
            container(
              color: Colors.white,
              child: SvgPicture.asset(
                'assets/images/search.svg',
                height: h(25),
                width: w(25),
              ),
            ),
          ],
        ),
  
  
          SizedBox(height: h(50),),
                Center(
                  child: text(text: "Support Requests",color: AppColor.blue,fontWeight: FontWeight.bold,fontsize: 18.sp,textAlign: TextAlign.center),
                ),
        BlocConsumer(
          bloc: settingsBloc,
          
          listener: (context, state) {
            if (state is Error){
              Toast.show(state.error, context);

            }
          },
          builder: (context, state) {
            if (state is LoadingSupportRequest){
              return const Center(child:  LoadingState());
            }
            if (state is SupportRequestState){
              supportRequestModel = state.supportRequestModel;

            }
            return 
        supportRequestModel.content.isNotEmpty?    customlistview(
                padding: h(40),
                controller: ScrollController(),
                direction: 'vertical',
                function: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(onTap: (){
                      nav(context, SupportRequestDetails(requestId: supportRequestModel.content[index].id,));
                    },
                      child: container(
                        
                          borderRadius: 10,
                          hight: h(60),
                          width: w(300),
                          color: Colors.white,
                          shadow: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  text(text: supportRequestModel.content[index].status,color: AppColor.blue),
                                ],
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 150.w,
                                    child: text(text: supportRequestModel.content[index].text,color: AppColor.blue,)),
                                ],
                              ),
                              text(text:supportRequestModel.content[index].creationDate.toString().substring(0,10),color: AppColor.blue)
                            ],
                          )),
                    ),
                  );
                },
                itemcount: supportRequestModel.content.length,
                scroll: true,
                hight: h(700)):SizedBox(height: 300,
                  child: Center(child: text(text: 'No Support requests for you',color: AppColor.blue,fontsize: 18.sp)));
          },
        )
      ]),
    );
  }
}
