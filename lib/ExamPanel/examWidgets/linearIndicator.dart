import 'package:examiapp/ExamPanel/examPage.dart';
import 'package:examiapp/ExamPanel/examWidgets/leaderBoard.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

//linear percent indicator
Widget LinearIndicator(BuildContext context, String correct, String wrong, String unanswered,String pMarks, String nMarks){
  double totalQuestions = double.parse(correct) + double.parse(wrong) + double.parse(unanswered);
  double totalMarks = totalQuestions* double.parse(pMarks);
  double correctPercentage = double.parse(correct) / totalQuestions;
  double wrongPercentage = double.parse(wrong) / totalQuestions;
  double unansweredPercentage = double.parse(unanswered) / totalQuestions;

  return Column(
    children: [
      Padding(
       padding: AppPadding.sidePadding,
       child: Container(
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(40),
           color: AppColors.backgrounColor,
         ),
         height: 200,
         width: MediaQuery.of(context).size.width,
         child: Padding(
           padding: AppPadding.allPadding,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('QUESTION SPLIT',style: TextStyle(fontSize: 17,
                   color: AppColors.lightText,),),
      
               SizedBox(height: 10,),
      
               //package linear percent inidcator
               LinearPercentIndicator(
                   lineHeight: 14.0,
                   backgroundColor: Colors.grey,
                   barRadius: Radius.circular(15),
      
                   padding: EdgeInsets
                       .zero, // Remove padding to properly align the progress segments
                   animation: true,
                   animationDuration: 2500,
                   linearGradient: LinearGradient(
                     colors: [
                       AppColors.correct,
                       AppColors.correct,
                       AppColors.wrong,
                       AppColors.wrong,
                       AppColors.unattemped,
                       AppColors.unattemped,
                     ],
                     stops: [
                       0.0,
                       correctPercentage,
                       correctPercentage,
                       correctPercentage + wrongPercentage,
                       correctPercentage + wrongPercentage,
                       1.0,
                     ],
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                   ),
                   percent:
                   1.0, // Set to 1.0 for demonstration (represents full progress)
                 ),
               SizedBox(height: 25,),
      
               Row(
                 children: [
                   Numbertext('$correct', 'Correct', AppColors.correct),
                   SizedBox(width: 30,),
                   Numbertext('$wrong', 'Wrong', AppColors.wrong),
                   SizedBox(width: 30,),
                   Numbertext('$unanswered', 'Unanswered', AppColors.unattemped),
                 ],
               )
             ],
           ),
         ),
       ),
       ),

      //showing leaderborad
      SizedBox(height: 30,),
      LeaderBoard(totalMarks: totalMarks.toString(),examId: examId,),
    ],
  );
}

Widget Numbertext(String num, String label, Color textcolor){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('$num',style: TextStyle(fontWeight: FontWeight.bold,
          color: textcolor,
        fontSize: 20,
      ),),
      SizedBox(height: 3,),
      Text('$label',style: TextStyle(color: AppColors.lightText,
      fontSize: 15,
      ),),
    ],
  );
}