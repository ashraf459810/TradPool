
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

abstract class BuyNowRemoteData {
  Future buyNow (String userId , String auctionId );
}


class BuyNowRemoteDataImp implements BuyNowRemoteData {
  final NetworkInf networkInf ;
  final NetworkFunctions networkFunctions ;

  BuyNowRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future buyNow(String userId, String auctionId) async {
    var response = await networkFunctions.postMethod(url: '/tradepool/buy-and-sell/buy-now?sellRequest=$auctionId&user=$userId',baseurl: networkInf.baseUrl);
    auctionDetailsModelFromJson(response);
  }
}