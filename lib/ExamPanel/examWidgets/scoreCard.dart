
import 'package:examiapp/ExamPanel/examWidgets/setTopper.dart';
import 'package:examiapp/ExamPanel/examWidgets/leaderBoard.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/getPofilePhoto.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:examiapp/utils/spinKit.dart';
import 'package:examiapp/utils/uid.dart';
import 'package:flutter/material.dart';

Widget ScoreCard(String examName, String examId, String correct, String  wrong, String unanswered,String pMarks, String nMarks) {
  double totalQuestions = double.parse(correct) + double.parse(wrong) + double.parse(unanswered);
  double accuracy = double.parse(correct) / totalQuestions * 100;
  int score = (int.parse(correct) * int.parse(pMarks)) - (int.parse(wrong) * int.parse(nMarks));
  double totalScore = 20;
  double totalPercent = (score / totalScore) * 100; // Note: totalPercent is a percentage, not a raw score

// Format accuracy and totalPercent to have only 2 digits after the decimal point
  String TotalScore = totalScore.toStringAsFixed(1);
  String Accuracy = accuracy.toStringAsFixed(1);
  String TotalPercent = totalPercent.toStringAsFixed(1);

  examName ='UP police computer operator mock test 1';

  //setTopper
  setTopper(examId, score.toString());

  return Padding(
    padding: AppPadding.sidePadding,
    child: Column(
      children: [
        //score card container
        Material(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(25),
          elevation: 5.0,
          child: Container(
            width: double.infinity,
            height: 525,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.greenAccent,
            ),

            //content of container
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //exam name
                      Flexible(
                        child: Text(
                          examName,
                          style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),

                      SizedBox(width: 20,),
                      //current user profile photo
                      getProfilePhoto(60.00, uid().toString()),
                    ],
                  ),

                  //horizontel card element function
                  SizedBox(height: 30,),
                  HorizontelScoreCardElement('score.png', 'Score:', '$score/$TotalScore'),
                  SizedBox(height: 15,),
                  HorizontelScoreCardElement('rank.png', 'Rank:', '745/1500'),
                 SizedBox(height: 15,),
                  HorizontelScoreCardElement('clock.png', 'Time:', '00:01:20/01:00:00'
                  ),
                  SizedBox(height: 15,),

                  //vertical card element function
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VerticalScoreCardElement('accuracy.png', 'Accuracy:', "$Accuracy"),
                      VerticalScoreCardElement('percentile.png', 'Percentile:', "$TotalPercent"),
                      VerticalScoreCardElement('attempt.png', 'Attempt:', "1"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    ),
  );
}

// horizontel card elements
Widget HorizontelScoreCardElement(String img, String title, String marks,){
  //checking null
  if (img!=null && title!=null && marks!=null) {
    return  Container(
      decoration: BoxDecoration(
        color: AppColors.backgrounColor,
        borderRadius: BorderRadius.circular(27),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15,top: 5,bottom: 5),
        child: Row(
          children: [
            Image.asset('assets/images/'+'$img',width: 40,height: 40,),

            //title and data
            SizedBox(width: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("$title",style: TextStyle(color: AppColors.lightText,fontSize: 20,fontWeight: FontWeight.bold),),
                Text('$marks',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ],
            )
          ],
        ),
      ),
    );
  }  else{
    return SpinKit();
  }
}

//vertical card element
//card elements
Widget VerticalScoreCardElement(String img, String title, String marks,){
  //checking null
  if (img!=null && title!=null && marks!=null) {
    return  Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        height: 110,
        width: 95,
        decoration: BoxDecoration(
          color: AppColors.backgrounColor,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5,top: 6,bottom: 5,right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/'+'$img',width: 40,height: 40,),
                SizedBox(height: 7,),
                //title and data
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$title",style: TextStyle(color: AppColors.lightText,fontSize: 15,fontWeight: FontWeight.bold),),
                    Text('$marks',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }  else{
    return SpinKit();
  }
}