import 'package:cached_network_image/cached_network_image.dart';
import 'package:examiapp/utils/spinKit.dart';
import 'package:examiapp/utils/uid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Make sure to declare the uid variable inside a function or method, not globally.
// Otherwise, it may not have the correct value at the time of initialization.

Widget getProfilePhoto(double radius, String UID) {
  return StreamBuilder(
    stream: FirebaseDatabase.instance
        .ref("Users")
        .child('${UID}')
        .child('profileImage')
        .onValue,
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // If the data is still loading, show a loading indicator
        return ProfileSpinKit();
      } else if (snapshot.hasError) {
        // If there's an error, display an error icon
        return Icon(Icons.error);
      } else {
        // If data is available, use CachedNetworkImage
        String? profileImageUrl = snapshot.data?.snapshot.value;
        return Material(
          child: Container(
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: profileImageUrl ?? "", // Ensure the URL is not null
                filterQuality: FilterQuality.medium,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    ProfileSpinKit(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              borderRadius: BorderRadius.circular(radius/2),
            ),
            height: radius,
            width: radius,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius/2),
              color: Colors.transparent,
            ),
          ),
          elevation: 3.0,
          borderRadius: BorderRadius.circular(radius/2),
          color: Colors.transparent,
        );
      }
    },
  );
}

Widget getName(String Uid){
  final nameref = FirebaseDatabase.instance.ref('Users').child(Uid);
  return StreamBuilder(
      stream: nameref.onValue,
      builder: (context, AsyncSnapshot snapshot) {
        var data = snapshot.data?.snapshot.value;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKit();
        } else if (snapshot.hasError) {
          return Flexible(child: Text('Error: ${snapshot.error}'));
        } else {
          var Name = data?['Name'] ?? "";
          String userName = Name.toString();
          return Flexible(child: Text(userName));
        }
      }
  );
}

Widget getEmail(String Uid){
  final nameref = FirebaseDatabase.instance.ref('Users').child(Uid);
  return StreamBuilder(
      stream: nameref.onValue,
      builder: (context, AsyncSnapshot snapshot) {
        var data = snapshot.data?.snapshot.value;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKit();
        } else if (snapshot.hasError) {
          return Flexible(child: Text('Error: ${snapshot.error}'));
        } else {
          var Name = data?['e-mail'] ?? "";
          String userName = Name.toString();
          return Flexible(child: Text(userName));
        }
      }
  );
}

Future<String> getUserName(String UID) async {
  final _ref = FirebaseDatabase.instance.ref("Users").child('$UID');
  DatabaseReference snapshot = await _ref;
  String name = snapshot.onValue.toString() ?? ""; // Use null-aware operator to handle null case
  return name;
}


Future<dynamic> getProfileImageUrl()async{
  final _ref = FirebaseDatabase.instance.ref("Users").child(uid().toString()).child('profileImage');
  DatabaseEvent event  = await _ref.once();
  DataSnapshot snapshot = event.snapshot;
  return snapshot.value;
}




Future<String> getEmailString()async{
  final _ref = FirebaseDatabase.instance.ref("Users").child(uid().toString());
  String name = await _ref.child('Name').toString();
  return name;
}

Future<String> getpMarks(String examId)async{
  DatabaseReference _ref = FirebaseDatabase.instance.ref("exams").child(examId).child('award/pMarks');
  DatabaseEvent event = await _ref.once();
  DataSnapshot snapshot = event.snapshot;
  String pMarks = snapshot.value as String;
  return pMarks;

}


Future<String> getnMarks(String examId)async{
  DatabaseReference _ref = FirebaseDatabase.instance.ref("exams").child(examId).child('award/nMarks');
  DatabaseEvent event = await _ref.once();
  DataSnapshot snapshot = event.snapshot;
  String nMarks = snapshot.value as String;
  return nMarks;

}

