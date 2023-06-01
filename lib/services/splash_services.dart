
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/routes/routes_name.dart';
import '../viewmodel/user_view_model.dart';
import '../web/model/response/loginResponse.dart';

class SplashServices{
  Future<LoginResponse> getLoginResponse()=>UserViewModel().getUser();

  void checkPreference(BuildContext context)async{
    getLoginResponse().then((value){

      if(value.token==null||value.token==''){
        if(kDebugMode){
          print("TOKEN 17:>>>>>>>"+value.token.toString());
        }
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        if(kDebugMode){
          print("TOKEN 22:>>>>>>>"+value.token.toString());
        }
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}