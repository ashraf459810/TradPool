
import 'package:http/http.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';



import 'package:tradpool/features/home/data/model/home_page_model.dart';

abstract class HomePageRemoteData {
  Future<dynamic> homePageRemoteData(String clientId);
}

class HomePageRemoteDataImp implements HomePageRemoteData{
    final Client client;
 
  final NetworkInf networkInf;


  HomePageRemoteDataImp( this.networkInf, this.client);

  @override
  Future homePageRemoteData(String clientId) async {
      NetworkFunctionsImp networkFunctions = NetworkFunctionsImp();
    var response = await networkFunctions.getMethod(url: '/tradepool/buy-and-sell/get-home-page-data?user=$clientId',baseurl: networkInf.baseUrl );
    return homePageModelFromJson(response);
  }
}