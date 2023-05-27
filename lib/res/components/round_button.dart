import 'package:flutter/material.dart';
import 'package:mydemomvvm/res/appColors.dart';
import 'package:mydemomvvm/utils/Constants.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton(
      {Key? key,
      required this.title,
      this.loading=false,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(10),gradient: const LinearGradient(colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ])),
        child: Center(
          child: loading?const CircleAvatar():Text(title.toUpperCase(),style: const TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}
