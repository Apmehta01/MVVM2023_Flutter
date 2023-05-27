
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mydemomvvm/repositories/auth_repository.dart';
import 'package:mydemomvvm/utils/routes/routes_name.dart';
import 'package:mydemomvvm/utils/uiUtils.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo=AuthRepository();
  bool _loading=false;
  bool get loading=>_loading;

  setLoading(bool loading){
    _loading=loading;
    notifyListeners();
  }
  Future<void> loginApi(dynamic data,BuildContext context) async{
    setLoading(true);
    _myRepo.loginApi(data).then((value){
      setLoading(false);
      UiUtils.flushBarSuccess(value.toString(),context);
      // Future<void>.delayed(const Duration(milliseconds: 500), gotoHome(context));
      Timer(const Duration(seconds: 4), () {
        gotoHome(context);
      });
      if(kDebugMode){
      print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      UiUtils.flushBarError(error.toString(),context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

  FutureOr<void> Function()? gotoHome(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.home);
  }
}