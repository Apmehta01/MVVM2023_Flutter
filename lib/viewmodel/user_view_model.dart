import 'package:flutter/material.dart';
import 'package:mydemomvvm/utils/Constants.dart';
import 'package:mydemomvvm/web/model/response/loginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(LoginResponse loginResponse) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(
        Constants.KEY_TOKEN, loginResponse.token.toString());
    notifyListeners();
    return true;
  }

  Future<LoginResponse> getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString(Constants.KEY_TOKEN);
    return LoginResponse(token: token.toString());
  }

  Future<bool> remove() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }
}
