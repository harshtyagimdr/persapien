import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persapien/presentation/home_page.dart';



class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double defaultHeight = 812;
  double defaultWidth = 375;
  Timer timer;



  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: defaultWidth, height: defaultHeight, allowFontScaling: false)
      ..init(context);
    _timer(context);

    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: 300,
          child:
         Image.asset('assets/logo.png'),
        ),
      ),
    );
  }

  _timer(context) {
    timer = new Timer(Duration(seconds: 2), () {
      _navigateToHomePage(context);
      timer.cancel();
    });
  }

 

  _navigateToHomePage(context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Scaffold(body: HomePage())));
  }


}
