import 'package:a_2102/api/negaposi_client.dart';
import 'package:a_2102/api/test_communication.dart';
import 'package:a_2102/pages/view/comparison_result.dart';
import 'package:a_2102/pages/view/scraping_screen.dart';
import 'package:a_2102/pages/view/sentences_screen.dart';
import 'package:a_2102/pages/view/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      //unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => TitleScreen()),
        GetPage(name: '/result', page: () => ComparisonResultScreen()),
        GetPage(name: '/sentences', page: () => SentencesScreen()),
      ],
    ),
  );
}