import 'dart:convert';

List<PairDatas> pairDatasFromJson(String str) =>
    List<PairDatas>.from(json.decode(str).map((x) => PairDatas.fromJson(x)));

String pairDatasToJson(List<PairDatas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PairDatas {
  PairDatas({
    this.pair,
    this.chanId,
    this.datas,
  });

  String pair;
  String chanId;
  Datas datas;

  factory PairDatas.fromJson(Map<String, dynamic> json) => PairDatas(
        pair: json["pair"] == null ? null : json["pair"],
        chanId: json["chanId"] == null ? null : json["chanId"],
        datas: json["datas"] == null ? null : Datas.fromJson(json["datas"]),
      );

  Map<String, dynamic> toJson() => {
        "pair": pair == null ? null : pair,
        "chanId": chanId == null ? null : chanId,
        "datas": datas == null ? null : datas.toJson(),
      };
}

class Datas {
  Datas({
    this.dailyChange,
    this.dailyChangePercent,
    this.lastPrice,
    this.dailyVolume,
    this.dailyHigh,
    this.dailyLow,
  });

  double dailyChange;
  double dailyChangePercent;
  double lastPrice;
  double dailyVolume;
  double dailyHigh;
  double dailyLow;

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        dailyChange: json["dailyChange"] == null ? null : json["dailyChange"],
        dailyChangePercent: json["dailyChangePercent"] == null
            ? null
            : json["dailyChangePercent"].toDouble(),
        lastPrice: json["lastPrice"] == null ? 0.0 : json["lastPrice"],
        dailyVolume: json["dailyVolume"] == null ? 0.0 : json["dailyVolume"],
        dailyHigh: json["dailyHigh"] == null ? 0.0 : json["dailyHigh"],
        dailyLow: json["dailyLow"] == null ? 0.0 : json["dailyLow"],
      );

  Map<String, dynamic> toJson() => {
        "dailyChange": dailyChange == null ? 0.0 : dailyChange,
        "dailyChangePercent":
            dailyChangePercent == null ? 0.0 : dailyChangePercent,
        "lastPrice": lastPrice == null ? 0.0 : lastPrice,
        "dailyVolume": dailyVolume == null ? 0.0 : dailyVolume,
        "dailyHigh": dailyHigh == null ? 0.0 : dailyHigh,
        "dailyLow": dailyLow == null ? 0.0 : dailyLow,
      };
}
