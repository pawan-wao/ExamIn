
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/app_elevations.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:flutter/material.dart';


// notice board
 Widget noticeBoard(){
  return Padding(
    padding: AppPadding.sidePadding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Text("Notice Board",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),

        //notice board card
        Material(
          elevation: AppElevations.cardElevation,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}