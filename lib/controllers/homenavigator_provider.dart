import 'package:coinzo/ui/pages/alsat_page.dart';
import 'package:coinzo/ui/pages/hesabim_page.dart';
import 'package:coinzo/ui/pages/homepage.dart';
import 'package:coinzo/ui/pages/yatircek_page.dart';
import 'package:flutter/cupertino.dart';

class HomeNavigatorProvider with ChangeNotifier {
  int _bottomNavIndex = 0;
  List<Widget> _navBarPages;
  List<String> _navBarNames;

  HomeNavigatorProvider() {
    _navBarPages = [
      MyHomePage(title: "Coinzo"),
      AlSatPage(),
      YatirCekPage(),
      HesabimPage(),
    ];
    _navBarNames = ["Market", "Al/Sat", "Yatır/Çek", "Hesabım"];
  }

  List<Widget> get navBarPages => _navBarPages;
  List<String> get navBarNames => _navBarNames;
  int get bottomNavIndex => _bottomNavIndex;

  set setBottomNavIndex(int val) {
    if (_bottomNavIndex == val) return;
    _bottomNavIndex = val;
    notifyListeners();
  }
}
