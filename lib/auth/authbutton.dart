import 'package:examiapp/auth/phone_Auth/otpscreen.dart';
import 'package:examiapp/auth/phone_Auth/phone_page.dart';
import 'package:examiapp/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

Widget AuthButton(String label, var fun){
  return  InkWell(
    onTap: fun,
    child: Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.lightBlueAccent,
      ),
      child: Center(child: Text("Next",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
    ),
  );
}


