import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/layout_view.dart';
import 'package:todo/features/login/page/login_view.dart';
import '../../../settings_provider.dart';

class SplashView extends StatefulWidget {
  static const String routeName = "/";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Image.asset(
        vm.isDark()
            ? "assets/images/splash_dark.png"
            : "assets/images/splash_light.png",
        fit: BoxFit.cover,
        height: mediaquery.height,
        width: mediaquery.width,
      ),
    );
  }
}
