import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ぷんぷく侍App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder:(context,child){
        return Scaffold(
          // drawer:MyDrawer(),
          body:child,
        );
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final cnt = 0.obs;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("ぷんぷく侍どっち行く〜",style:TextStyle(color: Colors.black)),backgroundColor:Colors.yellow ,
      ),
      body: Center(
        child:Container(
          child: Obx(() => Text("${cnt.value}")),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: () => cnt.value ++,
      ),

    );
  }
}