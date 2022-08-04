import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/buy/data/models/buy_model.dart';

abstract class PaidAuctionsRemoteData{
  Future<dynamic> getPaidAuctions(String userId);
}



class PaidAuctionsRemoteDataImp implements PaidAuctionsRemoteData{
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  PaidAuctionsRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future getPaidAuctions(String userId) async {
    var response = await networkFunctions.getMethod(url: '/tradepool/buy-and-sell/get-buy-list?user=$userId',baseurl: networkInf.baseUrl);
   return buyAuctionModelFromJson(response); 
  }
}