
import 'package:flutter/foundation.dart';

import '../model/response/homeScreenResponse.dart';
import '../network/app_urls.dart';
import '../network/base/BaseApiService.dart';
import '../network/base/NetworkApiService.dart';

class HomeRepository{
  BaseApiServices _apiServices=NetworkApiServicec();

  Future<HomeScreenResponse> fetchHomeScreenUserList()async{
    try{
      dynamic response=await _apiServices.getAPIResponse(AppUrls.homeScreen);
      return response=HomeScreenResponse.fromJson(response);
    }catch(e){
      if(kDebugMode){
        print("ERROR:>>>>>>>"+e.toString());
      }
      throw e;
    }
  }
}