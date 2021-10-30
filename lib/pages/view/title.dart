import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'comparison_result.dart';
import 'package:http/http.dart' as http;

import 'models/negaposi_model.dart';

Future<NegaposiRes> createNegaposiRes(String text1, String text2) async {
  final response = await http.post(
    Uri.parse('https://a2102-fast-api.herokuapp.com/comparison/'),
    headers: <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    },
    body: jsonEncode(<String, String>{'text1': text1, 'text2': text2}),
  );

  if (response.statusCode == 200) {
    return NegaposiRes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create text.');
  }
}

class TitleScreen extends StatelessWidget {
  final text1FocusNode = FocusNode();
  final text2FocusNode = FocusNode();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("比較する", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellow,
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(children: [
              TextFormField(
                controller: _controller1,
                focusNode: text1FocusNode,
                decoration: const InputDecoration(hintText: 'おにぎり'),
              ),
              TextFormField(
                controller: _controller2,
                focusNode: text2FocusNode,
                decoration: const InputDecoration(hintText: 'パスタ'),
              ),
              RaisedButton(
                  child: Text('submit'),
                  onPressed:(){
                        createNegaposiRes(
                            _controller1.text, _controller2.text).then((value){
                        Get.toNamed("/result", arguments: [value, _controller1.text, _controller2.text]);});
                      }),
            ]))
        // body: Center(
        //   child: ElevatedButton(
        //     child: Text("Go to Other"),
        //     onPressed: () => Get.to(inputCompare()),
        //   ),
        // ),

        // bottomNavigationBar: BottomNavigationBar(
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.contacts),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.history),
        //       label: 'History',
        //     ),
        //   ],
        // ),
        );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final cnt = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("ぷんぷく侍どっち行く〜", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Container(
          child: Obx(() => Text("${cnt.value}")),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: () => cnt.value++,
      ),
    );
  }
}
