import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';

import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';


import 'package:tradpool/features/home/presentation/widgets/list_view_item_widget.dart';
import 'package:tradpool/features/search/data/models/search_request_model.dart';
import 'package:tradpool/features/search/data/models/search_response_model.dart';
import 'package:tradpool/features/search/presentation/bloc/search_bloc.dart';

import '../../../../injection_container.dart';



// ignore: must_be_immutable
class SearchResult extends StatefulWidget {
   SearchResponseModel searchResponseModel;
  final SearchRequestModel searchRequestModel;

   SearchResult({Key key, this.searchResponseModel, this.searchRequestModel}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  SearchBloc searchBloc = sl<SearchBloc>();
  ScrollController scrollController = ScrollController();
  var buyAuctionModel= [];
  @override
  void initState() {
 buyAuctionModel = widget.searchResponseModel.content;
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(shrinkWrap: true,
              controller: scrollController,
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
          SizedBox(
            height: h(15),
          ),
         
              buyAuctionModel.isNotEmpty?
              NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              scrollController.position.extentAfter == 0) {
                          
                     widget.searchRequestModel.page ++;       

                          searchBloc
                                .add(GetSearchEvent( widget.searchRequestModel));
                          }

                          return false;
                        },
                        child:
                BlocBuilder(
                  bloc: searchBloc,
                  builder: (context, state) {
                    if (state is GetSearchState){ 
                buyAuctionModel = state.searchResponseModel.content;
                    }
                    return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(height: h(640),
                                    child: GridView.builder(
                                
                                        scrollDirection: Axis.vertical,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 220,
                                                childAspectRatio: 0.7,
                                                crossAxisSpacing: 15,
                                                mainAxisSpacing: 20),
                                        itemCount: buyAuctionModel.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return InkWell(onTap: (){
                                            nav(context, AuctionDetails(auctionId: buyAuctionModel[index].id,));
                                          },
                                            child: ListViewSample(
                                          
                                              subscriptionType:  buyAuctionModel[index].subscriptionType,
                                              price: buyAuctionModel[index].lastPrice !=null ?buyAuctionModel[index].lastPrice.toString() :"_",name: buyAuctionModel[index].name,
                                              category: buyAuctionModel[index].mainCategory.name,image:buyAuctionModel[index].attachments[0].publicUrl, timeToFinish: Duration(
                                                            days:  int.parse( buyAuctionModel[index].timeToEnd.split(':')[0] ),
                                                              hours:
                                                                 int.parse( buyAuctionModel[index].timeToEnd.split(':')[1]),
                                                              minutes:  int.parse( buyAuctionModel[index].timeToEnd.split(':')[2])
                                                                  ),brand: '',adsType:buyAuctionModel[index].sellType ,location: buyAuctionModel[index].location,viewers: buyAuctionModel[index].viewers.toString()
                                                                    ),
                                          );
                                        }),
                                  ),
                                );
                  },
                )):SizedBox(height: h(300),
                  child: Center(child: text(text: 'No Ads found',color: AppColor.darkBlue,fontsize: 18.sp)))
              
            
          ],
        ),
      ),
    );
  }
}
