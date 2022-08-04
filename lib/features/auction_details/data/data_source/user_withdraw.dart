
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

abstract class UserWithdrawRemoteData {
  Future userWithdraw ( String userid , String auctionId);
}


class UserWithdrawRemoteDataImp implements UserWithdrawRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  UserWithdrawRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future userWithdraw(String userid, String auctionId) async {

    var response = await networkFunctions.postMethod(baseurl: networkInf.baseUrl , url: '/tradepool/buy-and-sell/withdraw?user=$userid&sellRequest=$auctionId');

    return auctionDetailsModelFromJson(response); 
  }
  
}