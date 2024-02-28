import 'package:examiapp/utils/getPofilePhoto.dart';
import 'package:examiapp/utils/uid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void setTopper(examId, marksScored) async{
  //database reference
  final _ref = FirebaseDatabase.instance.ref('exams').child('$examId')
      .child('toppers');

  String name = await getUserName(uid().toString()).toString();
  String image= await getProfileImageUrl();

   await _ref.child(uid().toString()).set({
    "uid": '${uid().toString()}',
    'marks': marksScored.toString(),
  }).catchError((error){
    print("unable to update toppers list $error");
  });
}