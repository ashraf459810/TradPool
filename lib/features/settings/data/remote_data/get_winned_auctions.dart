import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/settings/data/model/winned_auctions_model.dart';

abstract class WinnedAuctionsRemoteData {
  Future<dynamic> winnedAuctions (String userId , String page, String size);
}

class WinnedAuctionsRemoteDataImp implements WinnedAuctionsRemoteData{
  final NetworkInf networkInf ;
  final NetworkFunctions networkFunctions;

  WinnedAuctionsRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future winnedAuctions(String userId, String page, String size) async {

    var response= await networkFunctions.getMethod(url: '/tradepool/buy-and-sell/get-winned-ads?user=$userId&page=$page&size=$size',baseurl: networkInf.baseUrl);
    return winnedAuctionsModelFromJson(response);
    
  }
}