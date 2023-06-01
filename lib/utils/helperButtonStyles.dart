import 'package:flutter/material.dart';

class HelperButtonStyles{
  /**
   *Name: [helperButtonStyles.dart] outlinedButtonStyle()
   *<br>  Created By Arpan Mehta on 24-05-23
   *<br>  Modified By Arpan Mehta on 24-05-23
   *<br>  Purpose: This method will enable toolbar in another activities.
   **/

  static ButtonStyle outlinedButtonStyle(Color primary,double borderWidth,Color secondary,double
  fontSize,double padding,double radius) {
    return OutlinedButton.styleFrom(
      primary:primary,
      side: BorderSide(color: secondary,width: borderWidth),
      textStyle: TextStyle(fontSize: fontSize),
      padding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

/**
 *Name: [helperButtonStyles.dart] ElevatedButtonStyle()
 *<br>  Created By Arpan Mehta on 24-05-23
 *<br>  Modified By Arpan Mehta on 24-05-23
 *<br>  Purpose: This method will enable toolbar in another activities.
 **/
  static ButtonStyle ElevatedButtonStyle(Color primary,Color secondary,double
  fontSize,double padding,double radius){
    return ElevatedButton.styleFrom(
      primary: primary,
      onPrimary: secondary,
      textStyle: TextStyle(fontSize: fontSize),
      padding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}