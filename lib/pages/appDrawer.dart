
import 'dart:core';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:examiapp/auth/email_auth/signIn.dart';
import 'package:examiapp/pages/homepage.dart';
import 'package:examiapp/utils/getPofilePhoto.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:examiapp/utils/spinKit.dart';
import 'package:examiapp/utils/uid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:examiapp/widgets/updateProfilePhoto.dart';
import '../utils/appColors.dart';
import '../widgets/homeScreenWidgets/appbar.dart';
import 'package:examiapp/utils/spinKit.dart';

final _ref = FirebaseDatabase.instance.ref("Users");

class AppDrawer extends StatefulWidget{
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 40,),

          StreamBuilder(
            stream: _ref
                .child(uid().toString())
                .onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return SpinKit();
              } else if (snapshot.data?.snapshot?.value == null) {
                return SpinKit();
              } else {
                Map<dynamic, dynamic> profileData = snapshot.data.snapshot
                    .value;
                return Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          UpdateProfilePhoto().showImagePicker(context).then((value) {
                            setState(() {});
                          });
                        },
                        //PROFILE PHOTO WIDGET
                        child: getProfilePhoto(100.00, uid().toString()),


                    ),
                    SizedBox(height: 15,),

                    Text(profileData['Name'], style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),

                    Text(profileData['email'], style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                );
              }
            },
          ),

          SizedBox(height: 30,),
          DrawerItem(Icons.edit_note, "Test Series"),
          DrawerItem(Icons.upcoming, "Upcoming Exams",),
          DrawerItem(Icons.chat_bubble, "Contact Us",),
          Spacer(),

          GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn(),));
                }).catchError((error) {
                  print("$error");
                });
              },
              child: DrawerItem(Icons.logout, "Logout")),
          SizedBox(height: 70,),
        ],
      ),
    );
  }

  // custom drawer item
  Widget DrawerItem(IconData icon, String label,) {
    return Padding(
      padding: AppPadding.sidePadding,
      child: Container(
        width: double.infinity,
        height: 60,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 20,),
            Text(label, style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),),
          ],
        ),
      ),
    );
  }

}