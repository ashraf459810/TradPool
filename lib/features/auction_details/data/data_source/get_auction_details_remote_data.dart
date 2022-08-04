import 'package:http/http.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

abstract class GetAuctionDetailsRemoteData {
  Future<AuctionDetailsModel> getAuctionDetails(String auctionid ,String userId);
}

class GetAuctionRemoteDataImp implements GetAuctionDetailsRemoteData {
  final Client client;
  final NetworkInf networkInf;

  GetAuctionRemoteDataImp(this.client, this.networkInf);

  @override
  Future<AuctionDetailsModel> getAuctionDetails(String auctionid , String userId) async {
    NetworkFunctionsImp networkFunctions = NetworkFunctionsImp();
    final response = await networkFunctions.getMethod(
        baseurl: networkInf.baseUrl,
        url:
            "/tradepool/buy-and-sell/get-auction-details?sellRequest=$auctionid&user=$userId");
            
    return auctionDetailsModelFromJson(response);
  }
}
