import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<BondText> createBondText(String text1, String text2) async {
  final response = await http.post(
    Uri.parse('https://a2102-fast-api.herokuapp.com/test/'),
    headers: <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: jsonEncode(<String, String>{
      'Text1': text1,
      'Text2': text2
    }),
  );

  if (response.statusCode == 200) {
    return BondText.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create text.');
  }
}

class BondText {
  final String res;
  final String text;

  BondText({required this.res, required this.text});

  factory BondText.fromJson(Map<String, dynamic> json) {
    return BondText(
      res: json['res'],
      text: json['text'],
    );
  }
}

class TestCommunicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Test Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestApiApp(),
    );
  }
}

class TestApiApp extends StatefulWidget {
  const TestApiApp({Key? key}) : super(key: key);

  @override
  _TestApiAppState createState() {
    return _TestApiAppState();
  }
}

class _TestApiAppState extends State<TestApiApp> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  Future<BondText>? _futureText;

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
          child: (_futureText == null) ? buildColumn() : buildFutureBuilder(),
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
              _futureText = createBondText(_controller1.text, _controller2.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<BondText> buildFutureBuilder() {
    return FutureBuilder<BondText>(
      future: _futureText,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.text);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}