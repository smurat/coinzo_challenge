import 'package:coinzo/controllers/socket_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:web_socket_channel/status.dart' as status;
import 'package:coinzo/utils/coinzo_icons.dart';
import 'package:coinzo/ui/widgets/tabbar_widget.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          // bottom:
          title: Icon(
            Coinzo.logo,
            size: 16,
            color: Color(0xFFFFFFFF),
          ),
          actions: [
            TabBar(
              tabs: socketCtrl.pairs.pairs
                  .map((e) => Container(
                        child: Center(
                          child: Text(e.pairName),
                        ),
                        // height: 28,
                      ))
                  .toList(),
              isScrollable: true,
            ),
          ],
        ),
        body: TabBarWidget(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
