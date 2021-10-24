import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class NegaposiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class SampleResponse{
  final String word_list;
  SampleResponse({
    required this.word_list,
  });
  factory SampleResponse.fromJson(Map<String, dynamic> json) {
    return SampleResponse(
      word_list: json["word_list"],
    );
  }
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var text = "ツナマヨ vs シャケ";
  Future<SampleResponse> requestApi() async{
    var url = "https://labs.goo.ne.jp/api/morph";
    var request = new SampleRequest(app_id: "7b595a6f365dd0c113ec8f7599694e7f4eda87e2de7868683492ab11f26a9b98",
        sentence:"ツナマヨとシャケはうまい",info_filter: "form",pos_filter: "名詞");
    final response = await http.post(url,body: json.encode(request.toJson()), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200){
      return SampleResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load post');
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("negaposi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
               text
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      // body: Center(
      //   child: FutureBuilder<SampleResponse>(
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           return Text(snapshot.data.word_list.toString());
      //         } else if (snapshot.hasError) {
      //           return Text("${snapshot.error}");
      //         }
      //         return CircularProgressIndicator();
      //       },
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
class SampleRequest {
  final String app_id;
  final String sentence;
  final String info_filter;
  final String pos_filter;
  late final String name;
  SampleRequest({
    required this.app_id,
    required this.sentence,
    required this.info_filter,
    required this.pos_filter,
});
  Map<String,dynamic> toJson() =>{
    "app_id":app_id,
    "text":sentence,
    "info_filter":info_filter,
    "pos_filter":pos_filter,
  };
}


