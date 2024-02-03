
import 'package:examiapp/widgets/homeScreenWidgets/appbar.dart';
import 'package:examiapp/widgets/test_series.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:examiapp/widgets/homeScreenWidgets/noticeboard.dart';
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              //calling app bar
              appBar(),
              //calling notice board
              SizedBox(height: 15,),
              noticeBoard(),

              //
              SizedBox(height: 25,),
              testSeries(),
            ],
          ),
        ),
      ),
    );
  }
}

