import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<NegaposiRes> createNegaposiRes(String text1, String text2) async {
  final response = await http.post(
    Uri.parse('https://a2102-fast-api.herokuapp.com/comparison/'),
    headers: <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: jsonEncode(<String, String>{'text1': text1, 'text2': text2}),
  );

  if (response.statusCode == 200) {
    return NegaposiRes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create text.');
  }
}

class NegaposiRes {
  final String res;
  final double score_1;
  final double score_2;

  NegaposiRes(
      {required this.res, required this.score_1, required this.score_2});

  factory NegaposiRes.fromJson(Map<String, dynamic> json) {
    return NegaposiRes(
        res: json['res'], score_1: json['score_1'], score_2: json['score_2']);
  }
}

class NegaposiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Test Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NegaposiClientApp(),
    );
  }
}

class NegaposiClientApp extends StatefulWidget {
  const NegaposiClientApp({Key? key}) : super(key: key);

  @override
  _NegaposiClientAppState createState() {
    return _NegaposiClientAppState();
  }
}

class _NegaposiClientAppState extends State<NegaposiClientApp> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  Future<NegaposiRes>? _negaposiRes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_negaposiRes == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller1,
          decoration: const InputDecoration(hintText: 'テキストを入力してください'),
        ),
        TextField(
          controller: _controller2,
          decoration: const InputDecoration(hintText: 'テキストを入力してください'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _negaposiRes =
                  createNegaposiRes(_controller1.text, _controller2.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<NegaposiRes> buildFutureBuilder() {
    return FutureBuilder<NegaposiRes>(
      future: _negaposiRes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Text(snapshot.data!.res),
              Text(snapshot.data!.score_1.toString()),
              Text(snapshot.data!.score_2.toString()),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
