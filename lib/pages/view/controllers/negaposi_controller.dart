import 'dart:async';
import 'dart:convert';

import 'package:a_2102/pages/view/models/negaposi_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

FutureBuilder<NegaposiRes> getNegaposiRes(_negaposiRes, member) {
    return FutureBuilder<NegaposiRes>(
      future: _negaposiRes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              if(member == "res") Text(snapshot.data!.res)
              else if(member == "imageUrl_1") Text(snapshot.data!.imageUrl_1)
              else if(member == "imageUrl_2") Text(snapshot.data!.imageUrl_2)
              else if(member == "score_1") Text(snapshot.data!.score_1.toString())
              else if(member == "score_2") Text(snapshot.data!.score_2.toString())
              else if(member == "sentences_1") Text(utf8.decode(snapshot.data!.sentence_1.toString().runes.toList()))
              else if(member == "sentences_2") Text(utf8.decode(snapshot.data!.sentence_2.toString().runes.toList()))
              else if(member == "urls_1") Text(snapshot.data!.siteUrl_1.toString())
              else if(member == "urls_2") Text(snapshot.data!.siteUrl_2.toString())
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }