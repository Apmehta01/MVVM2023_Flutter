
import 'package:mydemomvvm/web/network/app_urls.dart';
import 'package:mydemomvvm/web/network/base/BaseApiService.dart';
import 'package:mydemomvvm/web/network/base/NetworkApiService.dart';

class AuthRepository{
   BaseApiServices _apiServices=NetworkApiServicec();

   Future<dynamic> loginApi(dynamic data)async{
     try{
    dynamic response=await _apiServices.postAPIResponse(AppUrls.login, data);

    return response;
     }catch(e){
       throw e;
     }
   }

   Future<dynamic> signUpApi(dynamic data)async{
     try{
       dynamic response=await _apiServices.postAPIResponse(AppUrls.register, data);

       return response;
     }catch(e){
       throw e;
     }
   }
}