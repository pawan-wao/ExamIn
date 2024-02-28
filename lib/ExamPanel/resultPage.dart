import 'package:examiapp/ExamPanel/examWidgets/linearIndicator.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/getPofilePhoto.dart';
import 'package:examiapp/utils/spinKit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:examiapp/ExamPanel/examWidgets/scoreCard.dart';


class ResultPage extends StatefulWidget {
  String examId;
  String examName;

  ResultPage({required this.examId, required this.examName });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  //marks for correct answer
  String pMarks = "1";
  String nMarks = '0';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.backgrounColor,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.backgrounColor,
        body: SafeArea(
          child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {

              //getting marks for correct answer
              getpMarks(widget.examId).then((String value){
                if (pMarks.toString() == "1") {
                  setState(() {
                    pMarks = value;
                  });
                }
              },).catchError((error){
                print("here is error"+error);
              });
              //getting marks for wrong answer
              getnMarks(widget.examId).then((String value){
                if (nMarks.toString() == "0") {
                  setState(() {
                    nMarks = value;
                  });
                }
              },).catchError((error){
                print("here is error"+error);
              });


              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKit();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {


                int? correctCount = int.tryParse((snapshot.data?['correctCount'] ?? '').toString());
                int? wrongCount = int.tryParse((snapshot.data?['wrongCount'] ?? '').toString());
                int? unattemptedCount = int.tryParse((snapshot.data?['unattemptedCount'] ?? '').toString());


                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                     Text("hello world"),
                     ScoreCard(widget.examName, widget.examId, correctCount.toString(), wrongCount.toString(), unattemptedCount.toString(),  pMarks, nMarks),

                       SizedBox(height: 30,),
                      LinearIndicator(context, correctCount.toString(), wrongCount.toString(), unattemptedCount.toString(), pMarks, nMarks),

                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Map<String, int>> fetchData() async {

    String? uid = FirebaseAuth.instance.currentUser?.uid.toString();

    // Reference to the exam data in the database
    final examRef = FirebaseDatabase.instance.ref('Users').child('$uid').child('result').child('exam_id_1');

    // Fetch data
    DatabaseEvent event = await examRef.once();
    DataSnapshot snapshot = event.snapshot;

    // Initialize counts for correct, wrong, and unattempted questions
    int correctCount = 0;
    int wrongCount = 0;
    int unattemptedCount = 0;

    // Iterate through each question in the exam
    Map<dynamic, dynamic>? examData = snapshot.value as Map?;
    if (examData != null) {
      examData.forEach((questionNumber, questionData) {
        bool isCorrect = questionData["is_correct"] == "true";
        String selectedOption = questionData["selectedOption"];

        // Check if the question is attempted or unattempted
        if (selectedOption == "-1") {
          unattemptedCount++;
        } else if (isCorrect) {
          correctCount++;
        } else {
          wrongCount++;
        }
      });
    }

    // Return the counts as a map
    return {
      'correctCount': correctCount,
      'wrongCount': wrongCount,
      'unattemptedCount': unattemptedCount,
    };
  }
}
