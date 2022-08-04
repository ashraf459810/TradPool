import 'package:http/http.dart' as http;

abstract class HttpInterface {
  Future<dynamic> getrequest(String url);
  Future<dynamic> postrequest(String url, body);
    Future<dynamic> putrequest (String url,body);
  dynamic returnResponse(http.Response response);
}
