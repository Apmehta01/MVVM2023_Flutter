import 'package:flutter/material.dart';
import 'package:mydemomvvm/res/appColors.dart';
import 'package:mydemomvvm/res/components/round_button.dart';
import 'package:mydemomvvm/utils/Constants.dart';
import 'package:mydemomvvm/utils/routes/routes_name.dart';
import 'package:mydemomvvm/utils/uiUtils.dart';
import 'package:mydemomvvm/viewmodel/auth_view_model.dart';
import 'package:mydemomvvm/web/model/request/loginRequest.dart';
import 'package:provider/provider.dart';

import '../animations/FadeAnimation.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthViewModel>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                headerDesign(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: FadeAnimation(1.8, Column(
                    children: <Widget>[
                      textFormFields(),
                      const SizedBox(
                        height: 50,
                      ),
                      downButton(authViewModel),
                      const SizedBox(
                        height: 30,
                      ),
                      registerAccount()
                    ],
                  )),
                )
              ],
            ),
          ),
        ));
  }

  Widget headerDesign() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            width: 80,
            height: 200,
            child: FadeAnimation(1,Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/light-1.png'))),
            )),
          ),
          Positioned(
            left: 140,
            width: 80,
            height: 150,
            child: FadeAnimation(1.3,Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/light-2.png'))),
            )),
          ),
          Positioned(
            right: 40,
            top: 40,
            width: 80,
            height: 150,
            child: FadeAnimation(1.5,Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/clock.png'))),
            )),
          ),
          Positioned(
            child: FadeAnimation(1.6,Container(
              margin: const EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  Constants.LOGIN_TITLE.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
          )
        ],
      ),
    );
  }

  Widget textFormFields() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.COLORS_PRIMARY_TWO,
                blurRadius: 20.0,
                offset: Offset(0, 10))
          ]),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: AppColors.COLORS_PRIMARY_ONE, width: 2))),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Constants.HINT_EMAIL,
                  labelText: Constants.HINT_EMAIL,
                  prefixIcon: Icon(Icons.email_outlined,color: AppColors.COLORS_PRIMARY_ONE),
                  hintStyle: TextStyle(color: Colors.grey[400])),
              onFieldSubmitted: (value) {
                UiUtils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
                valueListenable: obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: passwordController,
                    obscureText: value,
                    focusNode: passwordFocusNode,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        hintText: Constants.HINT_PASSWORD,
                        labelText: Constants.HINT_PASSWORD,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.lock_outline_rounded,color: AppColors.COLORS_PRIMARY_ONE,),
                        suffixIcon: InkWell(
                            onTap: () {
                              obsecurePassword.value = !obsecurePassword.value;
                            },
                            child: Icon(obsecurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility,color: AppColors.COLORS_PRIMARY_ONE))),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget downButton(AuthViewModel authViewModel) {
    return FadeAnimation(2,
        RoundButton(
      loading: authViewModel.loading,
      title: Constants.LOGIN_TITLE,
      onPress: () {
        if (emailController.text.isEmpty) {
          UiUtils.flushBarError(Constants.EMAIL_EMPTY_ERROR, context);
        } else if (passwordController.text.isEmpty) {
          UiUtils.flushBarError(Constants.PASSWORD_EMPTY_ERROR, context);
        } else if (passwordController.text.length < 6) {
          UiUtils.flushBarError(Constants.PASSWORD_LENGTH_ERROR, context);
        }else{
          LoginRequest loginRequest=LoginRequest();
          loginRequest.email=emailController.text.toString();
          loginRequest.password=passwordController.text.toString();
          authViewModel.loginApi(loginRequest.performRequest(),context);
        }
      },
    )

    );
  }

  Widget registerAccount() {
    return FadeAnimation(1.5,InkWell(
      onTap: (){
        Navigator.pushNamed(context, RoutesName.signup_screen);
      },
      child: Text(
        Constants.REGISTER_LABEL,
        style: TextStyle(
            color: AppColors.COLORS_PRIMARY_ONE, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
