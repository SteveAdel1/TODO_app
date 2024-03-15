import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configLoading(){
  EasyLoading.instance
   // ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    //..progressColor = Colors.yellow
    ..indicatorColor = Color(0xFF5D9CEC)
    ..maskType=EasyLoadingMaskType.black
    ..backgroundColor=Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false ;
}