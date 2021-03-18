import 'package:coinzo/controllers/homenavigator_provider.dart';
import 'package:coinzo/ui/pages/bottom_nav_bar/nav_bar_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeNavigatorProvider>(context);

    return BottomNavigationBar(
      currentIndex: provider.bottomNavIndex,
      onTap: (val) {
        provider.setBottomNavIndex = val;
      },
      type: BottomNavigationBarType.shifting,
      iconSize: 24,
      unselectedIconTheme: IconThemeData(
        color: Theme.of(context).accentTextTheme.bodyText1.color,
        size: 32,
      ),
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).accentTextTheme.bodyText1.color,
        size: 32,
      ),
      // fixedColor: Theme.of(context).textTheme.bodyText1.color,
      showUnselectedLabels: false,
      unselectedFontSize: 10,
      selectedItemColor: Theme.of(context).accentTextTheme.bodyText1.color,
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).primaryColor,
      selectedLabelStyle: TextStyle(
        color: Theme.of(context).accentTextTheme.bodyText1.color,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        color: Theme.of(context).accentTextTheme.bodyText1.color,
      ),
      items: items(context),
    );
  }
}
