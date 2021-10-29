import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComparisonResultScreen extends StatelessWidget {
  @override
  Widget build(context) {
    // 更新された変数にアクセス
    return Scaffold(
      appBar: AppBar(
          title: Text("ぷんぷく侍どっち行く〜", style: TextStyle(color: Colors.black)),
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
              Text("結果内容",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  )),
              Text("○○○○（名称の表示）",
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
                      "おにぎり",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width:10),
                    Text(
                      'パスタ',
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
                      "100点",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width:10),
                    Text(
                      '100点',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 180.0,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width:10),
                    Container(
                      height: 180.0,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    )
                  ],
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
                    onPressed: () => {},
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
