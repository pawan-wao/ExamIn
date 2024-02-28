import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/appColors.dart';

Widget SquareBox(IconData icon){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: AppColors.iconColors,
    ),
    height: 60,
    width: 60,
    child: Icon(icon),
  );
}