import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/home/data/model/favourite_model.dart';

abstract class FetchUserFavouriteRemoteData {
  Future fetchUserFavourite (String userId);
}




class FetchUserFavouriteRemoteDataImp implements FetchUserFavouriteRemoteData {
  final NetworkInf networkInf;
  final NetworkFunctions networkFunctions ;

  FetchUserFavouriteRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future fetchUserFavourite(String userId) async {
   
  
   var response = await  networkFunctions.getMethod(url:  '/tradepool/buy-and-sell/get-liked-list?user=$userId' , baseurl: networkInf.baseUrl );

    return favouritesModelFromJson(response);
  }
}