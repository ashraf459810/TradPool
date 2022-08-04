import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/custom_list_view.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/settings/data/model/user_preferences_model.dart';
import 'package:tradpool/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../App/app.dart';
import '../../../../Widgets/container.dart';
import '../../../../injection_container.dart';

class UserPreferences extends StatefulWidget {
  const UserPreferences({Key key}) : super(key: key);

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
 List< UserPreferencesModel >userPreferencesModel =[];
  SettingsBloc settingsBloc = sl<SettingsBloc>();
  @override
  void initState() {
  settingsBloc.add(FetchUserPreferencesEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(shrinkWrap: true, children: [
      SizedBox(
        height: h(40),
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
          )
        ],
      ),
      SizedBox(
        height: h(50),
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
                        return const Center(child: LoadingState());
          }
              if (state is LoadingFetchUserPreferencesState){
                return const Center(child: LoadingState());
              }
              if (state is FetchUserPreferencesState){
                userPreferencesModel = state.userPreferencesModel;
              }
          return customlistview(
              controller: ScrollController(),
              direction: "vertical",
              scroll: false,
              itemcount: userPreferencesModel.length,
              padding: 10,
              // hight: h(50),
              function: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(child: container(hight: h(100),width: w(200),color: Colors.white,child: 
                  Column(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    
                 Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     SizedBox(
            
                       width: w(100),
                       child: text(text: "category",color: AppColor.blue,textAlign: TextAlign.start)),
                 
                     SizedBox(width: w(200),
                       child: text(text: userPreferencesModel[index].data[index].subCategory.name,color: AppColor.blue))
                   ],
                 )   ,
                 SizedBox(height: h(20),),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     SizedBox(width: w(100),
                     
                       child: text(text: "brand",color: AppColor.blue,textAlign: TextAlign.start)),
                     
                     SizedBox(
                       width: w(200),
                       child: text(text: userPreferencesModel[index].data[index].brands[index].name,color: AppColor.blue,))
                   ],
                 )  
                  ],))),
                );
              });
        },
      )
    ])));
  }
}
