import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SentencesScreen extends StatelessWidget {
  @override
  Widget build(context) {
    String firstHalf =
        "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.";
    String secondHalf =
        "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.";
    var flag = true.obs;
    // 更新された変数にアクセス
    return Scaffold(
      appBar: AppBar(
          title: Text("参考にした文章", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellow),
      body: Center(
        //
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(children: [
            //カード1
            Container(
                decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    border: Border.all(color: Colors.black)),
                padding:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: secondHalf.isEmpty
                    ? new Text(firstHalf)
                    : new Column(
                        children: <Widget>[
                          Obx(
                            () => Text((flag.isTrue)
                                ? (firstHalf + "...")
                                : (firstHalf + secondHalf)),
                          ),
                          InkWell(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Obx(() => Text(
                                      (flag.isTrue) ? "show more" : "show less",
                                      style: new TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                            onTap: () {
                              flag.toggle();
                            },
                          ),
                        ],
                      )),
                      SizedBox(height:20),
            //カード2
            Container(
                decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    border: Border.all(color: Colors.black)),
                padding:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: secondHalf.isEmpty
                    ? new Text(firstHalf)
                    : new Column(
                        children: <Widget>[
                          Obx(
                            () => Text((flag.isTrue)
                                ? (firstHalf + "...")
                                : (firstHalf + secondHalf)),
                          ),
                          InkWell(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Obx(() => Text(
                                      (flag.isTrue) ? "show more" : "show less",
                                      style: new TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                            onTap: () {
                              flag.toggle();
                            },
                          ),
                        ],
                      ))
          ]),
        ),
      ),
    );
  }
}
