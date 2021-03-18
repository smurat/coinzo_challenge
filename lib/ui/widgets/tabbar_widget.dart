import 'package:cached_network_image/cached_network_image.dart';
import 'package:coinzo/controllers/socket_controller.dart';
import 'package:coinzo/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: socketCtrl.pairs.pairs
          .asMap()
          .map((pageIndex, value) {
            return MapEntry(
              pageIndex,
              Column(
                children: [
                  Theme(
                    data: ThemeData(
                        textTheme: TextTheme(
                            bodyText1: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ))),
                    child: Container(
                      height: 28,
                      color: Color(0xFF19212C),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Coin",
                              style: TextStyle(fontSize: 12),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Fiyat",
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(width: 48),
                                Text(
                                  "Değişim",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: socketCtrl
                          .pairs.pairs[pageIndex].socketEvent.length,
                      itemBuilder: (context, index) {
                        return GetBuilder<SocketService>(
                          init: SocketService(),
                          builder: (socketCtrl) {
                            final itemIndex = socketCtrl.fullData
                                .indexWhere((e) =>
                                    e.pair ==
                                    socketCtrl.pairName(pageIndex, index));
                            bool isAllFilled =
                                (socketCtrl.fullData.length >= 14 &&
                                    socketCtrl.fullData[itemIndex].datas !=
                                        null);
                            return Align(
                              alignment: Alignment.center,
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    top: BorderSide(
                                        color: Color(0xFF3B424B),
                                        width: .5),
                                  )),
                                  child: isAllFilled
                                      ? ListTile(
                                          contentPadding:
                                              EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                  horizontal: 12.0),
                                          onTap: () {},
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                        socketCtrl.roundVal(
                                                          socketCtrl
                                                              .fullData[
                                                                  itemIndex]
                                                              .datas
                                                              .lastPrice,
                                                          isUsd: false,
                                                          isAltPair: false,
                                                        ),
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentTextTheme
                                                              .bodyText1
                                                              .color,
                                                        ),
                                                      ) ??
                                                      '',
                                                  SizedBox(width: 8),
                                                  Text(
                                                    socketCtrl
                                                        .pairs
                                                        .pairs[pageIndex]
                                                        .pairName,
                                                    style: TextStyle(
                                                      color: Theme.of(
                                                              context)
                                                          .accentTextTheme
                                                          .bodyText1
                                                          .color,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    socketCtrl
                                                                .pairs
                                                                .pairs[
                                                                    pageIndex]
                                                                .pairName ==
                                                            "TRY"
                                                        ? "≈ " +
                                                            socketCtrl
                                                                .roundVal(
                                                              (socketCtrl
                                                                      .fullData[
                                                                          itemIndex]
                                                                      .datas
                                                                      .lastPrice /
                                                                  Globals
                                                                      .UsdPrice),
                                                              isUsd: true,
                                                              isAltPair:
                                                                  false,
                                                            )
                                                        : "≈ " +
                                                            socketCtrl
                                                                .roundVal(
                                                              socketCtrl
                                                                  .fullData[
                                                                      itemIndex]
                                                                  .datas
                                                                  .lastPrice,
                                                              pairName: socketCtrl
                                                                  .pairs
                                                                  .pairs[
                                                                      pageIndex]
                                                                  .pairName,
                                                              isUsd: true,
                                                              isAltPair:
                                                                  true,
                                                            ),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                    textAlign:
                                                        TextAlign.end,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    "USD",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          leading: Container(
                                            width: 100,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 24,
                                                  width: 24,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${Globals.ImageEnd}${socketCtrl.pairs.pairs[pageIndex].socketEvent[index].toLowerCase()}.png",
                                                    fadeInDuration:
                                                        Duration(
                                                            milliseconds:
                                                                20),
                                                    fadeOutDuration:
                                                        Duration(
                                                            milliseconds:
                                                                20),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(socketCtrl
                                                    .pairs
                                                    .pairs[pageIndex]
                                                    .socketEvent[index]),
                                              ],
                                            ),
                                          ),
                                          trailing: Container(
                                            width: 75,
                                            child: Text(
                                              socketCtrl
                                                      .fullData[itemIndex]
                                                      .datas
                                                      ?.dailyChangePercent
                                                      ?.toStringAsFixed(2) +
                                                  "%",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: socketCtrl
                                                        .fullData[itemIndex]
                                                        .datas
                                                        .dailyChangePercent
                                                        .isNegative
                                                    ? Color(0xFFF16060)
                                                    : Color(0xFF01AA78),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        )
                                      : ListTile(
                                          contentPadding:
                                              EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                  horizontal: 16.0),
                                          onTap: () {},
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 16),
                                                width: 24,
                                                height: 24,
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            ],
                                          ),
                                          trailing: Container(width: 50),
                                          leading: Container(
                                            width: 100,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 24,
                                                  width: 24,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${Globals.ImageEnd}${socketCtrl.pairs.pairs[pageIndex].socketEvent[index].toLowerCase()}.png",
                                                    fadeInDuration:
                                                        Duration(
                                                            milliseconds:
                                                                20),
                                                    fadeOutDuration:
                                                        Duration(
                                                            milliseconds:
                                                                20),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(socketCtrl
                                                    .pairs
                                                    .pairs[pageIndex]
                                                    .socketEvent[index]),
                                              ],
                                            ),
                                          ),
                                        )),
                            );
                            // }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          })
          .values
          .toList(),
    );
  }
}