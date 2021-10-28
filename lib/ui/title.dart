import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'input_text.dart';

class TitleScreen extends StatelessWidget {
  final text1FocusNode = FocusNode();
  final text2FocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ぷんぷく侍App", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ),

      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              focusNode: text1FocusNode,
              decoration: const InputDecoration(
                hintText:'おにぎり'
              ),
            ),
            TextFormField(
              focusNode: text2FocusNode,
              decoration: const InputDecoration(
                  hintText:'パスタ'
              ),
            ),
            RaisedButton(
              child: Text('submit'),
              onPressed:
                    () => Get.to(inputCompare(),
                    ),
            ),

          ]
        )
      )
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
