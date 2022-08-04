import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';

import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/drop_down.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/Widgets/text_form.dart';
import 'package:tradpool/features/home/data/model/support_type_model.dart';
import 'package:tradpool/features/home/presentation/bloc/home_bloc.dart';

import 'package:tradpool/features/notifications/presentation/pages/notifications.dart';
import 'package:tradpool/features/search/presentation/pages/search.dart';

import '../../../../injection_container.dart';


class Support extends StatefulWidget {
  final List<SupportTypeModel> supportType;
  const Support({Key key, this.supportType}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  String supportId;
HomeBloc homeBloc = sl<HomeBloc>();
  String desc;
  String suportTypel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(children: [
       SizedBox(
              height: h(40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: w(10),
                // ),
                GestureDetector(
                  onTap: () {
                    nav(context, const Notifications());
                  },
                  child: container(
                    hight: h(36),
                    width: w(36),
                    color: Colors.white,
                    child: Center(
                        child: Icon(
                      Icons.notifications,
                      color: AppColor.darkBlue,
                      size: 30,
                    )),
                  ),
                ),
                SizedBox(
                  width: w(50),
                ),
                Image.asset(
                  "assets/images/logo.gif",
     fit: BoxFit.cover,
                    width: w(170),
                    height: h(30)
                ),
                SizedBox(
                  width: w(50),
                ),
                GestureDetector(onTap: (){
                  nav(context,const Search());
                },
                  child: container(
                           hight: h(36),
                      width: w(36),
                    color: Colors.white,
                    child: SvgPicture.asset(
                      'assets/images/search.svg',
                      height: h(25),
                      width: w(25),
                    ),
                  ),
                ),
               
                // container(
                //   color: Colors.white,
                //   child: SvgPicture.asset(
                //     'assets/images/cart.svg',
                //     height: h(25),
                //     width: w(25),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: h(40),),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: container(bordercolor: AppColor.blue,
                  child: DropDown(list: widget.supportType,getindex: (val){},hint:AppLocalizations.of(context).translate( 'Assistance Type'),chosenvalue: suportTypel,onchanged: (val){
                    suportTypel= val.name;
                    supportId = val.id.toString();
        
                  },),
                ),
              ),
            ),
            container(borderRadius: 10, color: Colors.white,hight: h(150),width: w(330),child: textform(controller: TextEditingController(),hint:AppLocalizations.of(context).translate(  'enter your problem here'),maxlines: 5,issecure: false,validation: 'name',hintColor: Colors.grey,padding: const EdgeInsets.all(20),function: (val){desc = val;}),

        ),
        SizedBox(height: h(30),),
        GestureDetector(onTap: (){
homeBloc.add(CreateSupportRequestEvent(supportId, desc));
Toast.show(AppLocalizations.of(context).translate( "thanks ..  we will contact you soon"), context);
Navigator.of(context).pop();
          
          
        },
          child: container(color: AppColor.blue,width: w(150),hight: h(50),borderRadius: 5,child: text(text: "submit",color: Colors.white)))
         ],),);
  }
}