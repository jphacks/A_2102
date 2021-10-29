import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class NegaposiRes {
  final String res;
  final String imageUrl_1;
  final String imageUrl_2;
  final double score_1;
  final double score_2;
  final List<dynamic> sentence_1;
  final List<dynamic> sentence_2;
  final List<dynamic> siteUrl_1;
  final List<dynamic> siteUrl_2;

  NegaposiRes({
      required this.res,
      required this.imageUrl_1,
      required this.imageUrl_2,
      required this.score_1,
      required this.score_2,
      required this.sentence_1,
      required this.sentence_2,
      required this.siteUrl_1,
      required this.siteUrl_2,
      });

  factory NegaposiRes.fromJson(Map<String, dynamic> json) {
    return NegaposiRes(
        res: json['res'],
        imageUrl_1: json['image_url_1'],
        imageUrl_2: json['image_url_2'],
        score_1: json['score_1'],
        score_2: json['score_2'],
        sentence_1: json['sentence_1'],
        sentence_2: json['sentence_2'],
        siteUrl_1: json['site_url_1'],
        siteUrl_2: json['site_url_2'],
        );
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
              Text(snapshot.data!.imageUrl_1),
              Text(snapshot.data!.imageUrl_2),
              Text(snapshot.data!.score_1.toString()),
              Text(snapshot.data!.score_2.toString()),
              Text(utf8.decode(snapshot.data!.sentence_1.toString().runes.toList())),
              Text(utf8.decode(snapshot.data!.sentence_2.toString().runes.toList())),
              Text(snapshot.data!.siteUrl_1.toString()),
              Text(snapshot.data!.siteUrl_2.toString()),
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
