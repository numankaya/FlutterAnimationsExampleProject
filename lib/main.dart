import 'package:animation_design/menu_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  //const Color backgroundColor = Color(0xFF5D5D5D);
  //SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //statusBarColor: backgroundColor,
  //statusBarIconBrightness: Brightness.light,
  //systemNavigationBarColor: Colors.pink,
  //statusBarBrightness: Brightness.dark,
  //));

  //SystemChrome.setPreferredOrientations(
  //[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
  //runApp(MyApp());
  //});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Menu Dashboard",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuDashboard(),
    );
  }
}
