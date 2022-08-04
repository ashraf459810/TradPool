import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/auction_details/data/model/auction_details.dart';

abstract class RateAndFeedBackRemoteData {

  Future<dynamic> rateAndFeedBack (String type , String auctionId,String feedBack, String rate ,String userId);

}

class RateAndFeedBackRemoteDataImp implements RateAndFeedBackRemoteData {

  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  RateAndFeedBackRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future rateAndFeedBack(String type, String auctionId, String feedBack, String rate, String userId) async {
    String url ;
   if (type == "buyer"){
     url =  '/tradepool/buy-and-sell/add-buyer-feedback?sellRequest=$auctionId&buyer=$userId&rate=$rate&feedback=$feedBack';
   }

   else { 
     url = '/tradepool/buy-and-sell/add-seller-feedback?sellRequest=$auctionId&seller=$userId&rate=$rate&feedback=$feedBack';
   }
  var response = await networkFunctions.postMethod(url: url , baseurl: networkInf.baseUrl);

  return auctionDetailsModelFromJson(response);
  }

}