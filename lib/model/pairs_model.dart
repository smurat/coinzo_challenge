import 'dart:convert';

Pairs pairsFromJson(String str) => Pairs.fromJson(json.decode(str));

String pairsToJson(Pairs data) => json.encode(data.toJson());

class Pairs {
  Pairs({
    this.pairs,
  });

  List<Pair> pairs;

  factory Pairs.fromJson(Map<String, dynamic> json) => Pairs(
        pairs: List<Pair>.from(json["pairs"].map((x) => Pair.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pairs": List<dynamic>.from(pairs.map((x) => x.toJson())),
      };
}

class Pair {
  Pair({
    this.pairName,
    this.socketEvent,
  });

  String pairName;
  List<String> socketEvent;

  factory Pair.fromJson(Map<String, dynamic> json) => Pair(
        pairName: json["pairName"],
        socketEvent: List<String>.from(json["socketEvent"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "pairName": pairName,
        "socketEvent": List<dynamic>.from(socketEvent.map((x) => x)),
      };
}
