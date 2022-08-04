import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradpool/App/app_localizations.dart';
import 'package:tradpool/Widgets/custom_list_view.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/home/data/model/faq_model.dart';

import '../../../../App/app.dart';
import '../../../../Core/consts.dart';
import '../../../../Widgets/container.dart';
import '../../../../Widgets/nav.dart';
import '../../../notifications/presentation/pages/notifications.dart';
import '../../../search/presentation/pages/search.dart';

class FAQ extends StatefulWidget {
  final List<FaqModel>faqModel;
  const FAQ({Key key, this.faqModel}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:     ListView(
        shrinkWrap: true,
        children: [
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
                  SizedBox(height: h(60),),
                  Row(
                    children: [
                      SizedBox(width: w(20),),
                      text(text: "FAQ ",color: AppColor.blue,fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(height: h(40),),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: customlistview(
                    
                      controller: ScrollController(),direction: "vertical",function: (context,index){

                      return GestureDetector(
                        onTap: (){
                          nav(context, QuestionAnswer(faqModel: widget.faqModel[index],));
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: h(10)),
                          child: text(text: AppLocalizations.of(context).locale.languageCode =="ar"?  widget.faqModel[index].arabicQuestion: widget.faqModel[index].question,textDecoration: TextDecoration.underline),
                        ),
                      );

                    },itemcount: widget.faqModel.length,padding: 1,scroll: false,),
                  )
        ],
      ),);
  }
}

class QuestionAnswer extends StatefulWidget {
 final FaqModel faqModel;
 const QuestionAnswer({Key key, this.faqModel}) : super(key: key);

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
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
                    SizedBox(height: h(50),),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(  AppLocalizations.of(context).locale.languageCode =="ar"?  widget.faqModel.arabicQuestion: widget.faqModel.question,style: TextStyle(color: AppColor.blue,fontSize: 14.sp,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: h(30),),
              Text(   AppLocalizations.of(context).locale.languageCode =="ar"?  widget.faqModel.arabicAnswer: widget.faqModel.answer),
            ],
          ),
        )
    ]),
      ),);
  }
}