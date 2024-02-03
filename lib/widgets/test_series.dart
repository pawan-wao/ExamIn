
import 'package:examiapp/pages/TestDetail.dart';
import 'package:examiapp/utils/app_elevations.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:examiapp/utils/roughwork.dart';
import 'package:cached_network_image/cached_network_image.dart';

// notice board
Widget testSeries(){
  return Padding(
    padding: AppPadding.sidePadding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Row(
          children: [
            Text("Test Series",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            Spacer(),
            Text("See All", style: TextStyle(),)
          ],
        ),
        SizedBox(height: 10,),
        
        //list of test series
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 11),
                  
                  //material widget used to give padding
                  child: Material(
                    elevation: AppElevations.cardElevation,
                    // container holding image
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TestDetail(index: index),));
                      },
                      child: Container(
                        height: 210,
                        width: 170,
                        //child of container holding image
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                              imageUrl: RoughWork().testSeriesImages[index],
                             fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
          ),
        )
      ],
    ),
  );
}