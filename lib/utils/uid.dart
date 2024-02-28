import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String? uid() {
  return FirebaseAuth.instance.currentUser?.uid;
}