import 'dart:convert';
import 'dart:io';

import 'package:mydemomvvm/utils/Constants.dart';
import 'package:mydemomvvm/web/network/base/BaseApiService.dart';
import 'package:http/http.dart' as http;
import '../app_exceptions.dart';

class NetworkApiServicec extends BaseApiServices {
  @override
  Future getAPIResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
     responseJson= returnResponse(response);
    } on SocketException {
      throw FetchDataException(Constants.INTERNET_ISSUE);
    }
    return responseJson;
  }

  @override
  Future postAPIResponse(String url,dynamic data) async{
    dynamic responseJson;
    try {
      final response =
          await http.post(Uri.parse(url),body:data).timeout(Duration(seconds: 10));
      responseJson= returnResponse(response);
    } on SocketException {
      throw FetchDataException(Constants.INTERNET_ISSUE);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw FetchDataException(response.body.toString());
      case 500:
        throw FetchDataException(response.body.toString());
      case 404:
        throw FetchDataException(response.body.toString());
      default:
        throw FetchDataException(
            Constants.SERVER_NOT_REACHABLE + response.statusCode.toString());
    }
  }
}
