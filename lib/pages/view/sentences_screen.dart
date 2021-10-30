import 'dart:convert';

import 'package:a_2102/pages/view/models/negaposi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SentencesScreen extends StatelessWidget {
  NegaposiRes responses = Get.arguments[0];
  String item1 = Get.arguments[1];
  String item2 = Get.arguments[2];
  @override
  Widget build(context) {
    var flag = true.obs;
    var sentences1 = [], sentences2 = [];
    for(int i = 0; i < responses.sentence_1.length; i++) sentences1.add(utf8.decode(responses.sentence_1[i].toString().runes.toList()));
    for(int i = 0; i < responses.sentence_2.length; i++) sentences2.add(utf8.decode(responses.sentence_2[i].toString().runes.toList()));
    var setence_string1 = "";
    for(int i = 0; i < responses.sentence_1.length; i++) setence_string1 = setence_string1 + (i != 0 ? '\n': '') + sentences1[i];
    var setence_string2 = "";
    for(int i = 0; i < responses.sentence_2.length; i++) setence_string2 = setence_string2 + (i != 0 ? '\n': '') + sentences2[i];

    // 更新された変数にアクセス
    return Scaffold(
      appBar: AppBar(
          title: Text("参考にした文章", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellow),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(children: [
              //カード1
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Text(item1, style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )),
                    Image.network(responses.imageUrl_1)
                  ],
                )),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                      border: Border.all(color: Colors.black)),
                  padding:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: sentences1[1].isEmpty
                      ? new Text(sentences1[0])
                      : new Column(
                          children: <Widget>[
                            Text(setence_string1),
                            // Obx(
                            //   () => Text((flag.isTrue)
                            //       ? (sentences1[0] + "...")
                            //       : (sentences1[0] + sentences1[1])),
                            // ),
                            InkWell(
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  // Obx(() => Text(
                                  //       (flag.isTrue) ? "show more" : "show less",
                                  //       style: new TextStyle(color: Colors.blue),
                                  //     )),
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
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(alignment: Alignment.topLeft,
                child: Text(item2, style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ))),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                      border: Border.all(color: Colors.black)),
                  padding:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: sentences2[1].isEmpty
                      ? new Text(sentences2[0])
                      : new Column(
                          children: <Widget>[
                            Text(setence_string2),
                            // Obx(
                            //   () => Text((flag.isTrue)
                            //       ? (sentences2[0] + "...")
                            //       : (sentences2[0] + sentences2[1])),
                            // ),
                            InkWell(
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  // Obx(() => Text(
                                  //       (flag.isTrue) ? "show more" : "show less",
                                  //       style: new TextStyle(color: Colors.blue),
                                  //     )),
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
      ),
    );
  }
}
