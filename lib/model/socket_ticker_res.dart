import 'dart:convert';

SocketTickerRes socketTickerResFromJson(String str) =>
    SocketTickerRes.fromJson(json.decode(str));

String socketTickerResToJson(SocketTickerRes data) =>
    json.encode(data.toJson());

class SocketTickerRes {
  SocketTickerRes({
    this.chanId,
    this.channel,
    this.event,
    this.pair,
  });

  String chanId;
  String channel;
  String event;
  String pair;

  factory SocketTickerRes.fromJson(Map<String, dynamic> json) =>
      SocketTickerRes(
        chanId: json["chanId"],
        channel: json["channel"],
        event: json["event"],
        pair: json["pair"],
      );

  Map<String, dynamic> toJson() => {
        "chanId": chanId,
        "channel": channel,
        "event": event,
        "pair": pair,
      };
}
