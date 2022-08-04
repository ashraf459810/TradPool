import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tradpool/App/app.dart';
import 'package:tradpool/App/app_localizations.dart';

import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/home/data/model/faq_model.dart';
import 'package:tradpool/features/home/presentation/bloc/home_bloc.dart';


import 'package:tradpool/features/login/presentation/pages/login.dart';
import 'package:tradpool/features/settings/presentation/widgets/add_preferences.dart';
import 'package:tradpool/features/settings/presentation/widgets/edit_profile.dart';
import 'package:tradpool/features/settings/presentation/widgets/user_preferences.dart';
import 'package:tradpool/features/settings/presentation/widgets/winned_ads.dart';
import '../../../../Widgets/app_builder.dart';
import '../../../../Widgets/default_app_bar.dart';
import '../../../../injection_container.dart';
import '../../../subscriptions/page/subscriptions.dart';
import '../widgets/faq.dart';
import '../widgets/support_requests.dart';


class Profile extends StatefulWidget {
 const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
} 

class _ProfileState extends State<Profile> {
 List< FaqModel> faqModel = [];
 String language;
  HomeBloc homeBloc = sl<HomeBloc>();

@override
  void initState() {
    homeBloc.add(GetFAQEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      var size =  MediaQuery.of(context).size;
    return Scaffold(
           floatingActionButton:  BlocBuilder(
             bloc : homeBloc,
             builder: (context, state) {
               if (state is GetFAQState){
               
                 faqModel=state.faqModel;
               }
               return FloatingActionButton(
                 child: const Icon(Icons.question_mark,color: Colors.white,),
                 backgroundColor: 
      Colors.grey,
                   // Menu items
                  onPressed: (){
              nav(context, FAQ(faqModel: faqModel,));
                    },
                  
                 );
             },
           ),

      body: ListView(
        shrinkWrap: true,
        children: [
                           SizedBox(
              height: h(40),
            ),
          SizedBox(height: h(40),
        width: w(300),
          child:const DefaultAppBar()),
            SizedBox(
              height: h(15),
            ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
     
                      SizedBox(
                        width: size.width * 0.5,
                        height: size.height * 0.0007,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: size.width * 0.3,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: size.width * 0.069),
                  
                          SizedBox(width: size.width * 0.029),
             
      
                        ],
                      ),
                    ],
                  )
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: size.width * 0.8,
           
            ),
          ),
      
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: size.width * 0.8,
                child: Column(
                  children: [
                      GestureDetector(onTap: (){
                      nav(context, const EditProfile());
                    },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 8, right: 16, top: 8, bottom: 8),
                           
                          ),
                          SizedBox(
                            width: size.width * 0.55,
                            child: text(
                           text :   'Edit Profile',
                  
                                  fontsize: 14.sp, color: AppColor.blue),
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.blue,
                                  size: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      indent: 8,
                      endIndent: 8,
                    ),
                    
                          GestureDetector(onTap: (){
       modalBottomSheetMenu();
                    },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 8, right: 16, top: 8, bottom: 8),
                           
                          ),
                          SizedBox(
                            width: size.width * 0.55,
                            child: text(
                           text :   'Language',
                  
                                  fontsize: 14.sp, color: AppColor.blue),
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.blue,
                                  size: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                        const Divider(
                      indent: 8,
                      endIndent: 8,
                    ),
                     GestureDetector(onTap: (){
                       nav(context, const Subscriptions());
                     },
                       child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 8, right: 16, top: 8, bottom: 8),
                             
                            ),
                            SizedBox(
                              width: size.width * 0.55,
                              child: text(
                             text : AppLocalizations.of(context).translate(  'subscription'),
                                       
                                    fontsize: 14.sp, color: AppColor.blue),
                              
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColor.blue,
                                    size: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                     ),
                
                        const Divider(
                      indent: 8,
                      endIndent: 8,
                    ),
                    GestureDetector(onTap: (){
                      nav(context, const WinnedAds());
                    },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 8, right: 16, top: 8, bottom: 8),
                           
                          ),
                          SizedBox(
                            width: size.width * 0.55,
                            child: text(
                             text: 'Winned Ads',
                          
                                  fontsize: 14.sp, color: AppColor.blue),
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.blue,
                                  size: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      indent: 8,
                      endIndent: 8,
                    ),
                    GestureDetector(onTap:(){

        
                    }
                  ,
                      child: GestureDetector(onTap: (){
                        nav(context, const SupportRequests());
                      },
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 8,
                                  right: 16,
                                  top: 8,
                                  bottom: 8),
                          
                            ),
                            SizedBox(
                              width: size.width * 0.55,
                              child:text(
                            text:    'Support Requests',
                 
                                    fontsize: 14.sp, color: AppColor.blue),
                              ),
                            
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColor.blue,
                                    size: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      indent: 8,
                      endIndent: 8,
                    ),
               
                       GestureDetector(onTap: (){
                         nav(context, const AddUserPreferences());
                       },
                         child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 8,
                                  right: 16,
                                  top: 8,
                                  bottom: 8),
                            
                            ),
                            SizedBox(
                              width: size.width * 0.55,
                              child: text(
                              text:  'Add Preferences',

                                    fontsize: 14.sp, color: AppColor.blue),
                              
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColor.blue,
                                    size: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                                                       ),
                       ),
                    
                    const Divider(
                      indent: 8,
                      endIndent: 8,
                    ),
                    GestureDetector(
                      onTap: (){
                        nav(context, const UserPreferences());
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 8,
                                right: 16,
                                top: 8,
                                bottom: 8),
                        
                          ),
                          SizedBox(
                            width: size.width * 0.55,
                            child: text(
                         text:     'Your Preferences',
                             
                                  fontsize: 14.sp, color: AppColor.blue),
                            ),
                          
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.blue,
                                  size: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: h(40),
          ),
          GestureDetector(onTap: (){
            navWithReplaceAll(context,const Login());
          },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.05,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: AppColor.blue)),
                  child: Center(
                    child: text(
                   text:   "LOG OUT",
                     
                          color: AppColor.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                
              ],
            ),
          )
        ],
      ),
          );
   
  }
     void modalBottomSheetMenu(){
        showModalBottomSheet(
          backgroundColor: Colors.white,
          isScrollControlled: true,
            context: context,
            builder: (builder){
              return  SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h,),
                    Text(AppLocalizations.of(context).translate( "Choose the Language"),style: TextStyle(color: AppColor.blue,fontSize: 18.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    Container(
                      height: 200.h,
                      color:Colors.white, //could change this to Color(0xFF737373), 
                                 //so you don't have to change MaterialApp canvasColor
                      child:  Container(
                          decoration:   const BoxDecoration(
                              color: Colors.white,
                              borderRadius:  BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0))),
                          child:  Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: DropdownButton<String>(
                                hint:  Text( AppLocalizations.of(context).translate (sl<SharedPreferences>().getString("Language"))??''),
                                isExpanded: true,
      value: language,
      icon: const Icon(Icons.arrow_drop_down,size: 25,),
      // elevation: 16,
      style:  TextStyle(color:AppColor.blue),
      underline:const SizedBox(),
      onChanged: (String newValue) {
        setState(() {
          language = newValue;
          sl<SharedPreferences>().setString("Language", newValue);
                 AppLocalizations.of(context).load();

                          AppBuilder.of(context).rebuild();
                        
          Navigator.of(context).pop();
        });
      },
      items: <String>['Arabic', 'English',]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          
          value: value,
          child: Text(value),
        );
      }).toList(),
    )
                            ),
                          )),
                    ),
                  ],
                ),
              );
            }
        );
      }
}