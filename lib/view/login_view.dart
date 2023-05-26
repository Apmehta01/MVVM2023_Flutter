import 'package:flutter/material.dart';
import 'package:mydemomvvm/res/components/round_button.dart';
import 'package:mydemomvvm/utils/Constants.dart';
import 'package:mydemomvvm/utils/uiUtils.dart';

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
  ValueNotifier<bool> obsecurePassword=ValueNotifier<bool>(true);

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    obsecurePassword.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height*1;

    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.LOGIN_TITLE),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: InputDecoration(
                hintText: Constants.HINT_EMAIL,
                labelText: Constants.HINT_EMAIL,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              onFieldSubmitted: (value) {
                UiUtils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(valueListenable: obsecurePassword, builder: (context,value,child){
                return TextFormField(
                  controller: passwordController,
                  obscureText: value,
                  focusNode: passwordFocusNode,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      hintText: Constants.HINT_PASSWORD,
                      labelText: Constants.HINT_PASSWORD,
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: InkWell(
                          onTap:(){
                            obsecurePassword.value=!obsecurePassword.value;
                          },
                          child: Icon(obsecurePassword.value? Icons.visibility_off_outlined:Icons.visibility))),
                );
            }),
            SizedBox(height: height*.1 ,),
            RoundButton(title: Constants.LOGIN_TITLE,onPress: (){
              if(emailController.text.isEmpty){
                UiUtils.flushBarError(Constants.EMAIL_EMPTY_ERROR, context);
              }else if(passwordController.text.isEmpty){
                UiUtils.flushBarError(Constants.PASSWORD_EMPTY_ERROR, context);
              }else if(passwordController.text.length<6){
                UiUtils.flushBarError(Constants.PASSWORD_LENGTH_ERROR, context);
              }
            },),
          ],
        ),
      ),
    );
  }
}
