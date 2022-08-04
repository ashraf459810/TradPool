import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/features/home/data/model/boutique_response_model.dart';
import 'package:tradpool/features/home/presentation/bloc/home_bloc.dart';


import '../../../../App/app.dart';
import '../../../../Core/consts.dart';
import '../../../../Widgets/default_app_bar.dart';
import '../../../../Widgets/nav.dart';
import '../../../../Widgets/text.dart';
import '../../../../injection_container.dart';
import '../../../add_auction/presentation/widgets/loading.dart';
import '../../../auction_details/presentation/pages/auction_details.dart';
import '../widgets/list_view_item_widget.dart';

class BoutiqeAuctions extends StatefulWidget {
  final String boutique;
 const BoutiqeAuctions({Key key, this.boutique}) : super(key: key);

  @override
  State<BoutiqeAuctions> createState() => _BoutiqeAuctionsState();
}

class _BoutiqeAuctionsState extends State<BoutiqeAuctions> {
  List<Content> boutiqrAuctions =[];
  HomeBloc homePageBloc = sl<HomeBloc>();
  @override
  void initState() {
    homePageBloc.add(GetBoutiqueAuctionsEvent(widget.boutique));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              
              BlocBuilder(
                bloc: homePageBloc,
                builder: (context, state) {
                  if (state is Loading){
                    return const Center(child:  LoadingState());
                  }
             if (state is GetBoutiqeAuctionsState){
                    boutiqrAuctions = state.boutiqeAuctionsResponseModel.content;
             }
                  return 
                boutiqrAuctions.isNotEmpty?  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(height: h(640),
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 240,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20),
                          itemCount: boutiqrAuctions.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(onTap: (){
                              nav(context, AuctionDetails(auctionId: boutiqrAuctions[index].id,));
                            },
                              child: ListViewSample(
                                tags:         boutiqrAuctions[index].tags,
                                // ignore: prefer_null_aware_operators
                                price: boutiqrAuctions[index].lastPrice==null? null : boutiqrAuctions[index].lastPrice.toString() ,name: boutiqrAuctions[index].name,
                                category: boutiqrAuctions[index].mainCategory.name,image:boutiqrAuctions[index].attachments.isNotEmpty? boutiqrAuctions[index].attachments[0].publicUrl:"https://cdn1.iconfinder.com/data/icons/nuuline-shops-venues/128/shop_store_retail_commerce-14-512.png", timeToFinish: Duration(
                                              days:  int.parse( boutiqrAuctions[index].timeToEnd.split(':')[0].substring(1,2) ),
                                                hours:
                                                   int.parse( boutiqrAuctions[index].timeToEnd.split(':')[1].substring(1,2)),
                                                minutes:  int.parse( boutiqrAuctions[index].timeToEnd.split(':')[2].substring(1,2))
                                                    ),brand: '',adsType:boutiqrAuctions[index].sellType ,location: boutiqrAuctions[index].location,viewers: boutiqrAuctions[index].viewers.toString()
                                                      ),
                            );
                          }),
                    ),
                  ):SizedBox(height: h(300),
                    child: Center(child: text(text: 'You did not buy ads yet',color: AppColor.blue,fontsize: 20.sp,)));
                },
              ),
            ],
          ),
        ),
      );
  }
}