import 'package:flutter/cupertino.dart';

class HelperUtils {
  static double getScreenHeight(context){
    return MediaQuery.of(context).size.height;
  }
   static double getScreenWidth(context){
    return MediaQuery.of(context).size.width;
  }
}