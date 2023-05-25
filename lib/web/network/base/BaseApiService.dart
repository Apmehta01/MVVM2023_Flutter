
abstract class BaseApiServices{
  Future<dynamic> getAPIResponse(String url);
  Future<dynamic> postAPIResponse(String url, dynamic data);
}