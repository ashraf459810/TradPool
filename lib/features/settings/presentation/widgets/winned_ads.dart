import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:tradpool/Widgets/nav.dart';
import 'package:tradpool/features/add_auction/presentation/widgets/loading.dart';
import 'package:tradpool/features/auction_details/presentation/pages/auction_details.dart';
import 'package:tradpool/features/settings/data/model/winned_auctions_model.dart';
import 'package:tradpool/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:tradpool/features/settings/presentation/widgets/winned_ads_list_item.dart';

import '../../../../App/app.dart';
import '../../../../Widgets/container.dart';
import '../../../../injection_container.dart';

class WinnedAds extends StatefulWidget {
  const WinnedAds({Key key}) : super(key: key);

  @override
  State<WinnedAds> createState() => _WinnedAdsState();
}

class _WinnedAdsState extends State<WinnedAds> {
  WinnedAuctionsModel winnedAuctions = WinnedAuctionsModel() ;
  SettingsBloc settingsBloc = sl<SettingsBloc>();
  @override
  void initState() {
    settingsBloc.add(const WinnedAuctionsEvent("0", "1000"));
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
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
    
                  height: h(30),
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
              height: h(15),
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
                       return const LoadingState();
                }
                if (state is LoadingWinnedAuctionsState){
                  return const LoadingState();
                }
                if (state is WinnedAuctionsState){
                  winnedAuctions = state.winnedAuctionsModel;
                }
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: w(40),vertical: h(10)),
                  child: SizedBox(
                    height: h(640),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                     
                        itemCount: winnedAuctions.content.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(onTap: (){
                            nav(context, AuctionDetails(auctionId: winnedAuctions.content[index].id,));
                          },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: WinnedAdsListItem(
                                                  price: winnedAuctions.content[index].lastPrice!=null   ? winnedAuctions.content[index].lastPrice.toString():"_",name: winnedAuctions.content[index].name,
                                    category:winnedAuctions.content[index].mainCategory.name,image:winnedAuctions.content[index].attachments[0].publicUrl, timeToFinish: Duration(
                                                  days:  int.parse(winnedAuctions.content[index].timeToEnd.split(':')[0] ),
                                                    hours:
                                                       int.parse( winnedAuctions.content[index].timeToEnd.split(':')[1]),
                                                    minutes:  int.parse( winnedAuctions.content[index].timeToEnd.split(':')[2])
                                                        ),brand: '',adsType:winnedAuctions.content[index].sellType ,location:winnedAuctions.content[index].location,viewers: winnedAuctions.content[index].viewers.toString()
                                                        ,auction: winnedAuctions.content[index],
                          
                              ),
                            ),
                          );
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
