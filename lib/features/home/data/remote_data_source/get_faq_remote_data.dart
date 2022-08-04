

// ignore_for_file: file_names

import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/home/data/model/faq_model.dart';






abstract class GetFAQRemoteData{ 
  Future<dynamic> getFAQ(String token);
}


class GetFAQRemoteDataImp implements GetFAQRemoteData{
  final NetworkInf networkInf; 
  final NetworkFunctions networkFunctions;

  GetFAQRemoteDataImp(this.networkInf, this.networkFunctions);

  @override
  Future getFAQ(String token) async {

    
    var response = await networkFunctions.getMethod(baseurl: networkInf.baseUrl,url: "/tradepool/client/get-all-faqs?user=$token");

    return faqModelFromJson(response);
    
  }
  
}