import 'dart:convert';

import 'package:coinzo/globals.dart';
import 'package:coinzo/model/pair_datas_model.dart';
import 'package:coinzo/model/pairs_model.dart';
import 'package:coinzo/model/socket_ticker_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/pair_datas_model.dart';

SocketService socketCtrl = SocketService.to;

class SocketService extends GetxController {
  static SocketService get to => Get.find<SocketService>();

  Pairs pairs;
  WebSocketChannel channel;
  List<dynamic> incomingDataEvents;
  PairDatas pairDatas;
  var _fullData = [].obs;
  Map<String, dynamic> tickVal = {};
  Map<String, dynamic> socketEventMap = {
    "event": "subscribe",
    "channel": "ticker"
  };
  Map<String, dynamic> json = {
    "pairs": [
      {
        "pairName": "TRY",
        "socketEvent": ["BTC", "ETH", "XRP", "EOS", "NEO", "HOT"]
      },
      {
        "pairName": "BTC",
        "socketEvent": ["ETH", "XRP", "EOS", "NEO"]
      },
      {
        "pairName": "ETH",
        "socketEvent": ["XRP", "EOS", "NEO", "HOT"]
      }
    ]
  };

  List<PairDatas> get fullData => _fullData.cast<PairDatas>();

  void connectSocket() {
    channel = IOWebSocketChannel.connect(Globals.WsApi);
  }

  String roundPairs(String name, double val) {
    switch (name) {
      case "TRY":
        return val.toStringAsFixed(3);
        break;
      case "BTC":
      case "ETH":
        return val.toStringAsFixed(6);
      default:
        return val.toString();
    }
  }

  String roundVal(double val,
      {@required bool isUsd, @required bool isAltPair, String pairName}) {
    if (isAltPair) {
      final indexVal =
          fullData.indexWhere((e) => e.pair == pairName + "-" + "TRY");
      val = fullData[indexVal].datas.lastPrice * val / Globals.UsdPrice;
    }
    final list = val.toString().split(".");
    if (isUsd) {
      if (list[0].length >= 4) {
        return val.toStringAsFixed(1);
      } else if (list[1].length >= 4) {
        return val.toStringAsFixed(4);
      } else
        return val.toString();
    } else {
      if (list[1].length >= 6) {
        return val.toStringAsFixed(6);
      } else if (list[1].length < 6 && list[1].length >= 4) {
        return val.toString();
      } else if (list[0].length >= 5) {
        return val.toStringAsFixed(0);
      } else if (list[0].length == 4) {
        return val.toStringAsFixed(1);
      } else if (list[0].length == 3) {
        return val.toStringAsFixed(2);
      } else if (list[0].length == 2) {
        return val.toStringAsFixed(3);
      } else
        return val.toStringAsFixed(5);
    }
  }

  void sendMessage() {
    try {
      connectSocket();
      pairs.pairs.forEach((e) {
        for (var item in e.socketEvent) {
          socketEventMap["pair"] = item + "-" + e.pairName;
          channel.sink.add(jsonEncode(socketEventMap));
        }
      });
      channel.stream.listen(
        (event) {
          var eventStr = event as String;
          if (eventStr.contains("chanId")) {
            var eventTicker = socketTickerResFromJson(eventStr);
            final pairD =
                PairDatas(chanId: eventTicker.chanId, pair: eventTicker.pair);
            fullData.add(pairD);
          } else {
            incomingDataEvents = jsonDecode(event);
            final datas = Datas(
              dailyChange: double.parse(incomingDataEvents[1][0]),
              dailyChangePercent: double.parse(incomingDataEvents[1][1]),
              lastPrice: double.parse(incomingDataEvents[1][2]),
              dailyVolume: double.parse(incomingDataEvents[1][3]),
              dailyHigh: double.parse(incomingDataEvents[1][4]),
              dailyLow: double.parse(incomingDataEvents[1][5]),
            );
            final eventIndex =
                fullData.indexWhere((e) => incomingDataEvents[0] == e.chanId);
            fullData[eventIndex].datas = datas;
          }
          update();
        },
        onError: (e) {
          print("Hata : $e");
        },
        onDone: () {
          print("Socket Done ${channel.closeCode}");
        },
      );
    } catch (e, s) {
      print("$e,$s");
    }
  }

  String pairName(int pageIndex, int index) {
    return pairs.pairs[pageIndex].socketEvent[index] +
        "-" +
        pairs.pairs[pageIndex].pairName;
  }

  @override
  void onInit() {
    pairs = Pairs.fromJson(json);
    sendMessage();
    super.onInit();
  }
}
