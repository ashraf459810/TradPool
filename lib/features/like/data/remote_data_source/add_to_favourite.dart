import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';

abstract class AddToFavouriteRemoteData {

  Future<void> addToFavourite (String auctionId , String userId,String likeOrUnlike);

}

class AddToFavouriteRemoteDataImp implements AddToFavouriteRemoteData{
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf ;

  AddToFavouriteRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<void> addToFavourite(String auctionId, String userId , String likeOrUnlike) async {

      return await networkFunctions.postMethod(baseurl: networkInf.baseUrl,url: '/tradepool/buy-and-sell/$likeOrUnlike?sellRequest=$auctionId&user=$userId');

  }
}