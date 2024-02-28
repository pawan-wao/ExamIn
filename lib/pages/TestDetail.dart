import 'package:cached_network_image/cached_network_image.dart';
import 'package:examiapp/ExamPanel/examPage.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:examiapp/utils/roughwork.dart';
import 'package:read_more_text/read_more_text.dart';

class TestDetail extends StatelessWidget{
  int index;
  TestDetail({
    required this.index
  }
  );
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: AppColors.backgrounColor,
      home: Scaffold(
        backgroundColor: AppColors.backgrounColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: AppPadding.sidePadding,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //App bar
                  Row(
                    children: [
                      InkWell(
                          onTap: (){













                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_rounded, color: Color(0xFFFD3920),)),
                      Spacer(),
                      Icon(CupertinoIcons.bookmark, color: Colors.grey,),
                    ],
                  ),
                  SizedBox(height: 30,),
              
                  // main image and 3 monkeys
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        //main container showing poster image
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.2,
                          width: MediaQuery.of(context).size.width*0.4,
              
                          //fetching required image
                          child: CachedNetworkImage(
                            imageUrl: RoughWork().testSeriesImages[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // rating
                        ],
                      ),
                    ],
                  ),
              
                  // product title
                  SizedBox(height: 20,),
                  Text("UP Police computer operator ",style:TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 17,
                  )),
              
                  SizedBox(height: 20,),
                  //Inside this course tag
                  Text("Inside this course",style:TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15,
                  )),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border:Border.all(color: AppColors.iconColors,width: 2,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.request_page,color: AppColors.iconColors,),
                          SizedBox(height: 5,),
                          Text('326'),
                          SizedBox(height: 2,),
                          Text('Test Series'),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 50,),
                  //movie description
                  //tittle - plot overview
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Plot Overview",style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                    child: ReadMoreText("sample",
                      numLines: 4,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                      readMoreText:'Read More',
                      readLessText: 'Show less',),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ExamPage(),));
                      },
                      child: Text("Give exam"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

