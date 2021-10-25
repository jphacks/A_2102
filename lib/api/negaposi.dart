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

class SampleResponse {
  final String wordList;

  SampleResponse({
    required this.wordList,
  });

  factory SampleResponse.fromJson(Map<String, dynamic> json) {
    return SampleResponse(
      wordList: json["word_list"],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String resultJson = "";

  Future<SampleResponse> requestApi() async {
    var url = Uri.parse("https://labs.goo.ne.jp/api/morph/");
    var request = new SampleRequest(
        appId:
            "7b595a6f365dd0c113ec8f7599694e7f4eda87e2de7868683492ab11f26a9b98",
        requestId: "record001",
        sentence: "ツナマヨとシャケはうまい",
        infoFilter: "form",
        posFilter: "名詞");
    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(request.toJson()));
    if (response.statusCode == 200) {
      var resultText = SampleResponse.fromJson(json.decode(response.body));
      resultJson = resultText.wordList;
      return Future<SampleResponse>.value();
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    requestApi();
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
              resultJson,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

class SampleRequest {
  final String? appId;
  final String? requestId;
  final String? sentence;
  final String? infoFilter;
  final String? posFilter;
  late final String? name;

  SampleRequest({
    required this.appId,
    required this.requestId,
    required this.sentence,
    required this.infoFilter,
    required this.posFilter,
  });

  Map<String, dynamic> toJson() => {
        "app_id": appId,
        "request_id": requestId,
        "text": sentence,
        "info_filter": infoFilter,
        "pos_filter": posFilter,
      };
}
