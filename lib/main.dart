import 'package:coinzo/controllers/homenavigator_provider.dart';
import 'package:coinzo/controllers/socket_controller.dart';
import 'package:coinzo/ui/pages/homenavigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeNavigatorProvider()),
      ],
      child: MyApp(),
    ),
  );
  Get.put(SocketService());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = 'WebSocket Demo';
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primaryColor: Color(0xFF1F2737),
        iconTheme: IconThemeData(color: Colors.black54),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        accentIconTheme: IconThemeData(color: Colors.white),
        scaffoldBackgroundColor: Color(0xFF19212C),
      ),
      home: HomeNavigator(),
    );
  }
}
