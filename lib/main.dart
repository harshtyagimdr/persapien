import 'package:flutter/material.dart';
import 'package:persapien/presentation/splash_page.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
     return new MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: new ThemeData(
         primarySwatch:Colors.blue,
       ),
      home: SplashPage());
    
}
}

