
import 'package:flutter/material.dart';
import 'package:mydemomvvm/web/model/base/api_response.dart';
import 'package:mydemomvvm/web/model/response/homeScreenResponse.dart';
import 'package:mydemomvvm/web/repositories/home_repositoy.dart';

class HomeScreenViewModel with ChangeNotifier{

  final _myRepo=HomeRepository();
  APIResponse<HomeScreenResponse> homeScreenUserList=APIResponse.loading();
  setHomeScreenUserList(APIResponse<HomeScreenResponse> response){
    homeScreenUserList=response;
    notifyListeners();
  }

  Future<void> fetchHomeScreeenData()async{
    setHomeScreenUserList(APIResponse.loading());
    _myRepo.fetchHomeScreenUserList().then((value){
      setHomeScreenUserList(APIResponse.completed(value));
    }).onError((error, stackTrace){
      setHomeScreenUserList(APIResponse.error(error.toString()));
    });
}
}
