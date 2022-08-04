import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Core/consts.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';
import 'package:tradpool/features/buy/data/models/buy_model.dart';
import 'package:tradpool/features/buy/presentation/bloc/buy_bloc.dart';
import 'package:tradpool/features/home/presentation/widgets/list_view_item_widget.dart';

import '../../../../Widgets/default_app_bar.dart';
import '../../../../injection_container.dart';


class Buy extends StatefulWidget {
  const Buy({Key key}) : super(key: key);

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  List<BuyAuctionModel> buyAuctionModel= [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BuyBloc>()..add(PaidAuctionsEvent()),
      child: Scaffold(
        body: SafeArea(
          child: ListView(shrinkWrap: true,
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
              
              BlocBuilder<BuyBloc, BuyState>(
                builder: (context, state) {
                  if (state is Loading){
                    return const Center(child:  LoadingState());
                  }
                  if (state is PaidAuctionState){
                    buyAuctionModel = state.buyAuctionModel;
                  }
                  if (state is Error){
                    return Text(state.error);
                  }
                  return 
                buyAuctionModel.isNotEmpty?  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(height: h(640),
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 240,
                                  childAspectRatio: 0.61,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20),
                          itemCount: buyAuctionModel.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(onTap: (){
                              nav(context, AuctionDetails(auctionId: buyAuctionModel[index].id,));
                            },
                              child: ListViewSample(
                                subscriptionType:  buyAuctionModel[index].subscriptionType,
                                tags:         buyAuctionModel[index].tags,
                                price: buyAuctionModel[index].lastPrice.toString(),name: buyAuctionModel[index].name,
                                category: buyAuctionModel[index].mainCategory.name,image:buyAuctionModel[index].attachments[0].publicUrl, timeToFinish: Duration(
                                              days:  int.parse( buyAuctionModel[index].timeToEnd.split(':')[0].substring(1,2) ),
                                                hours:
                                                   int.parse( buyAuctionModel[index].timeToEnd.split(':')[1].substring(1,2)),
                                                minutes:  int.parse( buyAuctionModel[index].timeToEnd.split(':')[2].substring(1,2))
                                                    ),brand: '',adsType:buyAuctionModel[index].sellType ,location: buyAuctionModel[index].location,viewers: buyAuctionModel[index].viewers.toString()
                                                      ),
                            );
                          }),
                    ),
                  ):SizedBox(height: h(300),
                    child: Center(child: text(text: 'You did not buy ads yet',color: AppColor.blue,fontsize: 16.sp,fontWeight: FontWeight.bold)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
