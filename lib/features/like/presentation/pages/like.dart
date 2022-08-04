import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';

import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';
import 'package:tradpool/features/home/data/model/favourite_model.dart';
import 'package:tradpool/features/home/presentation/widgets/list_view_item_widget.dart';

import 'package:tradpool/features/like/presentation/bloc/like_bloc.dart';

import '../../../../Widgets/default_app_bar.dart';
import '../../../../injection_container.dart';


class Like extends StatefulWidget {
  const Like({Key key}) : super(key: key);

  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  List<Content> favouritesList = [];
  @override
  void initState() {
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LikeBloc>()..add(FetchUserFavouriteEvent()),
      child: Scaffold(
          body: SafeArea(
              child: ListView(shrinkWrap: true, children: [
        SizedBox(
          height: h(40),
   ),          SizedBox(height: h(40),
        width: w(300),
          child:const DefaultAppBar()),
        SizedBox(
          height: h(15),
        ),
        BlocBuilder<LikeBloc, LikeState>(
          builder: (context, state) {
            if (state is Loading){
              return const Center(child:  LoadingState());
            }
            if (state is Error){

            }
            if (state is FetchUserFavouriteState){
              favouritesList = state.favouritesModel.content;

            }
            return favouritesList.isNotEmpty? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: h(640),
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 240,
                            childAspectRatio: 0.61,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 20),
                    itemCount: favouritesList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {
                          nav(
                              context,
                              AuctionDetails(
                                auctionId: favouritesList[index].id,
                              ));
                        },
                        child: ListViewSample(
                          subscriptionType:  favouritesList[index].subscriptionType,
                          tags: favouritesList[index].tags,
                          liked: null,
                            price: favouritesList[index].lastPrice.toString(),
                            name: favouritesList[index].name,
                            category: favouritesList[index].mainCategory.name,
                            image:favouritesList[index].attachments.isNotEmpty? favouritesList[index].attachments[0].publicUrl:  "https://cdn1.iconfinder.com/data/icons/nuuline-shops-venues/128/shop_store_retail_commerce-14-512.png"
,
                            timeToFinish: Duration(
                                days: int.parse(favouritesList[index]
                                    .timeToEnd
                                    .split(':')[0].substring(1,2)),
                                hours: int.parse(favouritesList[index]
                                    .timeToEnd
                                    .split(':')[1].substring(1,2)),
                                minutes: int.parse(favouritesList[index]
                                    .timeToEnd
                                    .split(':')[2].substring(1,2))),
                            brand: '',
                            adsType:favouritesList[index].sellType,
                            location: favouritesList[index].location,
                            viewers:favouritesList[index].viewers.toString()),
                      );
                    }),
              ),
            ): SizedBox(height: h(300),child: Center(child: text(text: 'No Items in your favourite',color: AppColor.blue,fontWeight: FontWeight.bold,fontsize: 15.sp)) );
          },
        )
      ]))),
    );
  }
  
}
