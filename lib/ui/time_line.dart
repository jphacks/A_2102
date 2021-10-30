import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class TimeLine extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('data').snapshots();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('タイムライン',style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loadingなう→これだと進行形の二乗");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['item_1'] + " VS " +data['item_2']),
                  subtitle: Text((double.parse(data['score_1']) > double.parse(data['score_2']) ? data['item_1']:data['item_2'])+
                      "の勝ち"),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/timeline'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}