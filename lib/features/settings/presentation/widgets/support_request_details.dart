import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/settings/data/model/support_request_model.dart';
import 'package:tradpool/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../App/app.dart';
import '../../../../Widgets/container.dart';
import '../../../../injection_container.dart';

class SupportRequestDetails extends StatefulWidget {
  final String requestId;
  const SupportRequestDetails({Key key, this.requestId}) : super(key: key);

  @override
  State<SupportRequestDetails> createState() => _SupportRequestDetailsState();
}

class _SupportRequestDetailsState extends State<SupportRequestDetails> {
  SupportRequestDetailsModel supportRequestDetailsModel = SupportRequestDetailsModel();
  SettingsBloc settingsBloc = sl<SettingsBloc>();
  @override
  void initState() {
    settingsBloc.add(SupportRequestDetailsEvent(widget.requestId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      children: [
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
            Image.asset(
              "assets/images/logo.gif",
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
        SizedBox(
          height: h(50),
        ),
        Padding(
          padding:  EdgeInsets.only(left:w(10)),
          child: text(
              text: "Request Details",
              color: AppColor.blue,
              fontWeight: FontWeight.bold,
              fontsize: 18.sp),
        ),
        BlocConsumer(
        bloc: settingsBloc,
          listener: (context, state) {
           if (state is Error){
             Toast.show(state.error, context);
           }
          },
          builder: (context, state) {
            if (state is SettingsInitial){
                      return  const Center(child: LoadingState());
            }
            if (state is LoadingSupportRequest){
              return  const Center(child: LoadingState());
            }
            if (state is SupportRequestDetailsState){

              supportRequestDetailsModel =state.supportRequestModel;

            }
            return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children :[
                               SizedBox(
                   width: w(350),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       text(text: 'Name',color: AppColor.blue),
                       text(text: supportRequestDetailsModel.client.name,fontsize: 12.sp,color: Colors.grey),
       
                     ],
                   ),
               ) ,
               SizedBox(height: h(10),),
               SizedBox(
                   width: w(350),
                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       text(text: 'Type',color: AppColor.blue),
                       text(text: supportRequestDetailsModel.type.code,fontsize: 12.sp,color: Colors.grey),
       
                     ],
                   ),
               ) ,
               SizedBox(height: h(10),),
                     SizedBox(
                       width: w(350),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                       text(text: 'Text',color: AppColor.blue),
                       text(text: supportRequestDetailsModel.text,fontsize: 12.sp,color: Colors.grey),
       
                   ],
               ),
               
                     ) ,
                                    SizedBox(height: h(10),),
                     SizedBox(
                       width: w(350),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                       text(text: 'Final Decision',color: AppColor.blue),
                supportRequestDetailsModel.finalDecision !=null?       text(text: supportRequestDetailsModel.finalDecision,fontsize: 12.sp,color: Colors.grey):text(text:'pending',color: Colors.grey),
       
                   ],
               ),
               
                     ) ,
                                                     SizedBox(height: h(10),),
                     SizedBox(
                       width: w(350),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                       text(text: 'Date',color: AppColor.blue),
            text(text: supportRequestDetailsModel.creationDate.toString().substring(0,10),fontsize: 12.sp,color: Colors.grey)
       
                   ],
               ),
               
                     ) ,
               
                     ] ),
                ));
          },
        )
      ],
    ));
  }
}
