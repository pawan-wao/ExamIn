import 'package:cached_network_image/cached_network_image.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:examiapp/utils/roughwork.dart';
import 'package:read_more_text/read_more_text.dart';

class TestDetail extends StatelessWidget{

  int index;

  TestDetail({required this.index
  });

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      color: AppColors.backgrounColor,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              
              //App bar
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 50,),
                child: Row(
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
              ),
              SizedBox(height: 30,),

              // main image and 3 monkeys
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                      //main container showing poster image
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.4,
                        width: MediaQuery.of(context).size.width*0.6,
                        
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
                        Container(
                          height: 95,
                          width: 100,
                          decoration: BoxDecoration(color:Color(0xFF262428),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25), bottomRight: Radius.circular(25),
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.star,color: Color(0xFFFD3920,),size: 25),
                              SizedBox(height: 6,),
                              Text("sample",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 17),),
                              SizedBox(height: 4,),
                              Text("sample",style: TextStyle(fontSize: 17,color: Colors.grey),),
                              SizedBox(height: 4,),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),

                        // Duration
                        Container(
                          height: 95,
                          width: 100,
                          decoration: BoxDecoration(color:Color(0xFF262428),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25), bottomRight: Radius.circular(25),
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.clock_fill,color: Color(0xFFFD3920,),size: 25),
                              SizedBox(height: 6,),
                              Text('2h 10m',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 17),),
                              SizedBox(height: 4,),
                              Text("Duration",style: TextStyle(fontSize: 17,color: Colors.grey),),
                              SizedBox(height: 4,),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),

                        // year
                        Container(
                          height: 95,
                          width: 100,
                          decoration: BoxDecoration(color:Color(0xFF262428),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25), bottomRight: Radius.circular(25),
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month,color: Color(0xFFFD3920,),size: 25),
                              SizedBox(height: 6,),
                              Text('sample',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 17),),
                              SizedBox(height: 4,),
                              Text("Year",style: TextStyle(fontSize: 15,color: Colors.grey),),
                              SizedBox(height: 4,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
