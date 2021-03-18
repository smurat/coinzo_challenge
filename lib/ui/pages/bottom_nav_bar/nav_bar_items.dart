  import 'package:coinzo/utils/coinzo_icons.dart';
import 'package:flutter/material.dart';

List<BottomNavigationBarItem> items(BuildContext context) {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.bar_chart,
        ),
        label: "Market",
        backgroundColor: Theme.of(context).primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Coinzo.smallIcon,
        ),
        label: 'Al/Sat',
        backgroundColor: Theme.of(context).primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.money,
        ),
        label: "Yatır/Çek",
        backgroundColor: Theme.of(context).primaryColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        label: "Hesabım",
        backgroundColor: Theme.of(context).primaryColor,
      ),
    ];
  }