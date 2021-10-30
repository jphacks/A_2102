import 'package:a_2102/pages/view/controllers/negaposi_controller.dart';
import 'package:a_2102/pages/view/models/negaposi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComparisonResultScreen extends StatelessWidget {
  NegaposiRes responses = Get.arguments[0];
  String item1 = Get.arguments[1];
  String item2 = Get.arguments[2];

  @override
  Widget build(context) {
    // 更新された変数にアクセス
    return Scaffold(
      appBar: AppBar(
          title: Text("比較結果", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellow),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            SizedBox(height: 50.0),
            //上部テキスト「結果内容」
            Column(
            children: [
              Text("結果",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  )),
                  Text((responses.score_1 > responses.score_2 ? item1 : item2),
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  )),
              Text("これで決まりでござるペンよ🐧",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  )),
            ]),
            SizedBox(height: 50.0),
            //結果グラフ囲い
            Container(
              padding: const EdgeInsets.all(15.0),
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                children: [
                //結果グラフ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      item1,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width:10),
                    Text(
                      item2,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      (responses.score_1 * 100).toString() + "点",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width:10),
                    Text(
                      (responses.score_2 * 100).toString() + "点",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  height:180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: (responses.score_1 * 180.0),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width:10),
                      Container(
                        height: (responses.score_2 * 180.0),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height:5),
              ]), //結果グラフ
            ),
            SizedBox(height: 40),
            //button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 67,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all(color: Colors.black)
                  ),
                  child: TextButton(
                    child: Text("NEXT", style : TextStyle(fontWeight: FontWeight.w600)),
                    onPressed: () => { Get.toNamed("/sentences", arguments: [responses, item1, item2]) },
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
