
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydemomvvm/res/components/round_button.dart';
import 'package:mydemomvvm/utils/Constants.dart';
import 'package:mydemomvvm/utils/routes/routes_name.dart';
import 'package:mydemomvvm/utils/uiUtils.dart';
import 'package:mydemomvvm/viewmodel/auth_view_model.dart';
import 'package:mydemomvvm/web/model/request/loginRequest.dart';
import 'package:mydemomvvm/web/model/request/signUpRequest.dart';
import 'package:provider/provider.dart';

import '../animations/FadeAnimation.dart';
class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
                  child: FadeAnimation(1.8,Column(
                    children: <Widget>[
                      textFormFields(),
                      const SizedBox(
                        height: 50,
                      ),
                      downButton(authViewModel),
                      const SizedBox(
                        height: 30,
                      ),
                      gotoLogin()
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
            ),
          )),
          Positioned(
            child: FadeAnimation(1.6,Container(
              margin: const EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  Constants.SIGN_UP_TITLE.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              )),
            ),
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
            const BoxShadow(
                color: Color.fromRGBO(143, 148, 251, .2),
                blurRadius: 20.0,
                offset: Offset(0, 10))
          ]),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromRGBO(143, 148, 251, 1), width: 2))),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Constants.HINT_EMAIL,
                  labelText: Constants.HINT_EMAIL,
                  prefixIcon: const Icon(Icons.email_outlined,color: Color.fromRGBO(143, 148, 251, 1)),
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
                        prefixIcon: const Icon(Icons.lock_outline_rounded,color: Color.fromRGBO(143, 148, 251, 1),),
                        suffixIcon: InkWell(
                            onTap: () {
                              obsecurePassword.value = !obsecurePassword.value;
                            },
                            child: Icon(obsecurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility,color: Color.fromRGBO(143, 148, 251, 1)))),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget downButton(AuthViewModel authViewModel) {
    return FadeAnimation(2,RoundButton(
      loading: authViewModel.loading,
      title: Constants.SIGN_UP_TITLE,
      onPress: () {
        if (emailController.text.isEmpty) {
          UiUtils.flushBarError(Constants.EMAIL_EMPTY_ERROR, context);
        } else if (passwordController.text.isEmpty) {
          UiUtils.flushBarError(Constants.PASSWORD_EMPTY_ERROR, context);
        } else if (passwordController.text.length < 6) {
          UiUtils.flushBarError(Constants.PASSWORD_LENGTH_ERROR, context);
        }else{
          SignUpRequest signUpRequest=SignUpRequest();
          signUpRequest.email=emailController.text.toString();
          signUpRequest.password=passwordController.text.toString();
          authViewModel.signUpApi(signUpRequest.performRequest(),context);
        }
      },
    ));
  }

  Widget gotoLogin() {
    return FadeAnimation(1.5,InkWell(
      onTap: (){
        Navigator.pushNamed(context, RoutesName.login);
      },
      child: Text(
        Constants.STR_LOGIN_BACK,
        style: const TextStyle(
            color: Color.fromRGBO(143, 148, 251, 1), fontWeight: FontWeight.bold),
      ),
    ));
  }
}