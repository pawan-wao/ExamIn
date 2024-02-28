import 'package:examiapp/ExamPanel/resultPage.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:examiapp/utils/uid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import '../utils/appColors.dart';

final _ref = FirebaseDatabase.instance.ref("exams");
final _user = FirebaseDatabase.instance.ref("Users");

int currentQID = 1;
String Squid = "";
int SquidInt =0;
String Uid = uid().toString();
String examId = 'exam_id_1';
DateTime startTime = DateTime.now();
bool isSelected=false;

class ExamPage extends StatefulWidget {
  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int selectedOptionIndex = -1;
  Color selectedColor = AppColors.optionBackGroundColor;
  Map<int, int> selectedOptionsMap = {}; // Store selected options for each question
  int totalQuestions = 0;

  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: AppColors.backgrounColor,
      home: Scaffold(
        backgroundColor: AppColors.backgrounColor,
        body: SafeArea(
          child: StreamBuilder(
            stream: _ref.child(examId).onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                Squid = currentQID.toString().padLeft(3, '0');
                SquidInt =int.parse(Squid);
                var data = snapshot.data!.snapshot.value;
                String examName = data?['exam_name'] ?? "";
                var questions = data?['questions'] ?? {};
                totalQuestions = questions.length;

                return Padding(
                  padding: AppPadding.sidePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$examName",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                             TimerCountdown(
                               format: CountDownTimerFormat.hoursMinutesSeconds,
                               endTime: DateTime.now().add(
                                 Duration(
                                   hours: 01,
                                   minutes: 27,
                                   seconds: 34,
                                 ),
                               ),
                               onEnd: () {
                                 Duration timeSpent = DateTime.now().difference(startTime);
                                 print("Time spent: ${timeSpent.inHours} hours, ${timeSpent.inMinutes % 60} minutes, ${timeSpent.inSeconds % 60} seconds");
                               },
                             ),
                            ],
                          ),
                          Spacer(),

                          Icon(
                            Icons.menu,
                            color: AppColors.iconColors,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Question:" + " $currentQID",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          "${questions.containsKey(Squid) ? questions[Squid]['question_text'] ?? '' : ''}",

                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      options("A",
                          "${questions.containsKey(Squid) ? questions[Squid]['answers']['01']['text'] ?? '' : ''}"
                          , 1,"${questions.isNotEmpty ? questions[Squid]['answers']['01']['is_correct'] ?? '' : ''}"),
                      options("B",
                          "${questions.containsKey(Squid) ? questions[Squid]['answers']['02']['text'] ?? '' : ''}"
                          , 2,"${questions.isNotEmpty ? questions[Squid]['answers']['02']['is_correct'] ?? '' : ''}"),
                      options("C",
                          "${questions.containsKey(Squid) ? questions[Squid]['answers']['03']['text'] ?? '' : ''}"
                          , 3,"${questions.isNotEmpty ? questions[Squid]['answers']['03']['is_correct'] ?? '' : ''}"),
                      options("D",
                          "${questions.containsKey(Squid) ? questions[Squid]['answers']['04']['text'] ?? '' : ''}"
                          , 4,"${questions.isNotEmpty ? questions[Squid]['answers']['04']['is_correct'] ?? '' : ''}"),
                      SizedBox(
                        height: 70,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (currentQID == 1) {
                                print("Nothing behind, Go ahead");
                              } else {
                                setState(() {
                                  currentQID = currentQID - 1;
                                  selectedOptionIndex = selectedOptionsMap[currentQID] ?? -1;
                                });
                              }
                            },
                            child: Text("Previous"),
                          ),
                          Spacer(),
                          currentQID < totalQuestions
                              ? ElevatedButton(
                            onPressed: () async {

                              //if isSelected is false, any option is not selected tahn add selectedoption as -1
                              addNotSelectedOption().then((value){
                                setState(() {
                                  currentQID = currentQID + 1;
                                  selectedOptionIndex = selectedOptionsMap[currentQID] ?? -1;

                                  //setting isSelected false for next question
                                  isSelected = false;

                              });


                              });
                            },
                                child: Text("Next"),
                          )
                              : ElevatedButton(
                                onPressed: () async {
                                addNotSelectedOption().then((value){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(examId: examId,examName: examName),));
                               // print("Exam ended $selectedOptionsMap");
                              });
                            },
                                  child: Text("Submit"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return SpinKit();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget options(String option, String text, int index, String optionIndex) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: () {
          setState(() {
            //setting is selected as true
            isSelected=true;

            if (selectedOptionIndex == index) {
              selectedOptionIndex = -1;
            } else {
              selectedOptionIndex = index;
            }
            selectedOptionsMap[currentQID] = selectedOptionIndex;

            if (isSelected==true) {
              //add selected data to firebase
              // Squid >> question number, selectedOptionIndex >>Option selected, is_correct >>correct or not
              print(Uid);
              _user.child(Uid).child('result').child(examId).child(Squid).set({
                "selectedOption": selectedOptionIndex.toString(),
                "is_correct": optionIndex.toString(),
              }).then((value)  {
                //on sucess
                print("option data added sucesfully");
              }).catchError((e){
                print("option data error: $e");
              });
            }

          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: selectedOptionIndex == index ? selectedColor : Colors.transparent,
          ),
          width: double.infinity,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.optionColor,
                  child: Text(option),
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget SpinKit() {
    return SpinKitThreeBounce(
      color: AppColors.iconColors,
      size: 20.0,
      duration: Duration(milliseconds: 1000),
    );
  }
}
//not selected function
//if isSelected is false, any option is not selected tahn add selectedoption as -1
Future<void> addNotSelectedOption() async {
  if (!isSelected) {
    try {
      await _user.child(Uid).child('result').child(examId).child(Squid).set({
        "selectedOption": "-1",
        "is_correct": "false",
      });
    } catch (e) {
      print("Option data error: $e");
    }
  }
}
