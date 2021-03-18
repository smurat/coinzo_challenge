import 'package:coinzo/controllers/homenavigator_provider.dart';
import 'package:coinzo/ui/pages/bottom_nav_bar/custom_bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNavigator extends StatefulWidget {
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeNavigatorProvider>(context);
    return Scaffold(
      appBar: provider.bottomNavIndex == 0
          ? null
          : AppBar(
              title: Text(provider.navBarNames[provider.bottomNavIndex]),
              brightness: Brightness.dark,
            ),
      body: provider.navBarPages[provider.bottomNavIndex],
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
