import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/Widgets/custom_list_view.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';
import 'package:tradpool/features/settings/data/model/user_history_model.dart';
import 'package:tradpool/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tradpool/features/settings/presentation/widgets/user_history_card.dart';

import '../../../../App/app.dart';
import '../../../../Widgets/container.dart';
import '../../../../injection_container.dart';

class UserHistory extends StatefulWidget {
  final String auctionId;
  const UserHistory({Key key, this.auctionId}) : super(key: key);

  @override
  State<UserHistory> createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  UserHistoryModel userHistoryModel = UserHistoryModel();
  SettingsBloc settingsBloc = sl<SettingsBloc>();
  @override
  void initState() {
   settingsBloc.add(UserHistoryEvent(widget.auctionId, "0", "100"));
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
          Image.asset(
            "assets/images/logo.gif",
          fit: BoxFit.cover,
                    width: w(170),
                    height: h(30)
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
        height: h(30),
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
          if (state is LoadingUserHistoryState){
            return const Center(child: LoadingState());
          }
        if (state is UserHistoryState){
          userHistoryModel = state.userHistoryModel;
        }
          return customlistview(
            controller: ScrollController(),
            direction: "vertical",
            function: (context, index) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: w(30),vertical: h(20)),
                child: GestureDetector(onTap: (){
                  nav(context, AuctionDetails(auctionId:userHistoryModel.content[index].id ,));
                },
                  child: UserHistoryItem(auction: userHistoryModel.content[index],image:userHistoryModel.content[index].attachments.isNotEmpty?  userHistoryModel.content[index].attachments[0].publicUrl:'',timeToFinish: Duration(
                                                  days:  int.parse(userHistoryModel.content[index].timeToEnd.split(':')[0] .substring(1,2) ),
                                                    hours:
                                                       int.parse( userHistoryModel.content[index].timeToEnd.split(':')[1].substring(1,2) ),
                                                    minutes:  int.parse( userHistoryModel.content[index].timeToEnd.split(':')[2].substring(1,2) ,)
                                                        ),adsType:userHistoryModel.content[index].sellType ,location:userHistoryModel.content[index].location,viewers: userHistoryModel.content[index].viewers.toString(),brand: "",category: userHistoryModel.content[index].mainCategory.name,fixedPrice: userHistoryModel.content[index].directSellPrice.toString()??"_",price: userHistoryModel.content[index].lastPrice.toString() ?? "_",),
                )
              );
            },
            itemcount: userHistoryModel.content.length,
            padding: 1,
            scroll: false,
          );
        },
      )
    ])));
  }
}
