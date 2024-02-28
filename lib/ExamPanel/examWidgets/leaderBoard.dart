import 'package:cached_network_image/cached_network_image.dart';
import 'package:examiapp/ExamPanel/examPage.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/getPofilePhoto.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:examiapp/utils/spinKit.dart';
import 'package:examiapp/utils/uid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  String totalMarks;
  String examId;
  LeaderBoard({required this.totalMarks, required this.examId});

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<Map<String, dynamic>> toppersDataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    DatabaseReference _toppersRef = FirebaseDatabase.instance
        .ref('exams')
        .child(examId)
        .child('toppers');

    DatabaseEvent event = await _toppersRef.orderByChild('marks').once();

    DataSnapshot snapshot = event.snapshot;
    if (snapshot != null && snapshot.value != null) {
      Map<String, dynamic> toppersData =
      Map<String, dynamic>.from(snapshot.value as Map ?? {});

      List<Map<String, dynamic>> tempList = [];

      // Iterate through the first 10 toppersData entries
      toppersData.forEach((String uid, dynamic topperData) {
        String marks = topperData['marks'];
        String topperUid = topperData['uid'];
        // Add the data to the list
        tempList.add({'uid': topperUid, 'marks': marks});
      });

      // Sort the list in descending order based on 'marks'
      tempList.sort((a, b) {
        double marksA = double.parse(a['marks']);
        double marksB = double.parse(b['marks']);
        return marksB.compareTo(marksA);
      });



      // save rank to firebase

      setState(() {
        toppersDataList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.sidePadding,
      child: Column(
        children: [
          Text(
            'Leaderboard',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text(
            'Rising stars',
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
          SizedBox(height: 20),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: toppersDataList.length,
            itemBuilder: (context, index) {
              String currentUid = '${toppersDataList[index]['uid']}'.toString();
              String currentMarks = '${toppersDataList[index]['marks']}'.toString();

              // Check for null or empty strings
              if (currentUid != null &&
                  currentMarks != null &&
                  index < 10) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.leaderBoard,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        // Rank
                        Text(
                          "${index + 1}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 15),
                        getProfilePhoto(60.0, currentUid),
                        SizedBox(width: 20),
                        Flexible(
                          child: getName(currentUid),
                        ),
                        // Marks container
                        Container(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white24.withOpacity(0.7),
                            ),
                            child: Text('$currentMarks'+"/"+widget.totalMarks),
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: SizedBox(height: 1),
                );
              }
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
