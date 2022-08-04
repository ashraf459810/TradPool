
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/features/search/data/models/search_request_model.dart';
import 'package:tradpool/features/search/data/models/search_response_model.dart';

abstract class SearchRemoteDate {
  Future<dynamic> search (SearchRequestModel searchRequestModel);
}






class SearchRemoteDateImp implements SearchRemoteDate {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf ;

  SearchRemoteDateImp(this.networkFunctions, this.networkInf);

  @override
  Future search(SearchRequestModel searchRequestModel) async {
    var response = await networkFunctions.getMethod(baseurl: networkInf.baseUrl,
      url: '/tradepool/buy-and-sell/search?name=${searchRequestModel.name}&mainCategory=${searchRequestModel.mainCategoryId}&subCategory=${searchRequestModel.subCategoryId}&brand=${searchRequestModel.brandId}&minPrice=${searchRequestModel.minPrice}&maxPrice=${searchRequestModel.maxPrice}&productCondition=${searchRequestModel.condition}&fixedPrice=${searchRequestModel.isFixed??''}&auction=${searchRequestModel.isAuction ?? ''}&deliverType=${searchRequestModel.deliverType}&shippingPayer=${searchRequestModel.shippingBuyer}&location=${searchRequestModel.location}&page=${searchRequestModel.page}&size=${searchRequestModel.size}');
    return searchResponseModelFromJson(response);
  }
}