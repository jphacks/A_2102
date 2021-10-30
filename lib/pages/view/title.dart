import 'dart:convert';

import 'package:a_2102/pages/view/controllers/negaposi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'comparison_result.dart';
import 'package:http/http.dart' as http;

import 'models/negaposi_model.dart';

class TitleScreen extends StatelessWidget {
  final text1FocusNode = FocusNode();
  final text2FocusNode = FocusNode();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loading = false.obs;

    return Scaffold(
        appBar: AppBar(
          title: Text("比較する", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.yellow,
        ),
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Obx(()=>
              loading.isTrue ? CircularProgressIndicator() : (
              Column(children: [
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
                    onPressed: () {
                      loading.toggle();
                      createNegaposiRes(_controller1.text, _controller2.text)
                          .then((value) {
                        loading.toggle();
                        Get.toNamed("/result", arguments: [
                          value,
                          _controller1.text,
                          _controller2.text
                        ]);
                      });
                    }),
              ]
              )))
              ),
        ));
  }
}
