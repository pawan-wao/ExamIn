import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/pages/appDrawer.dart';
import 'package:examiapp/widgets/homeScreenWidgets/appbar.dart';
import 'package:examiapp/widgets/test_series.dart';
import 'package:flutter/material.dart';
import 'package:examiapp/widgets/homeScreenWidgets/noticeboard.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

final advancedDrawerController = AdvancedDrawerController();
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return AdvancedDrawer(
      //animation of drawer
      drawer: AppDrawer(),
      controller: advancedDrawerController,
      backdropColor: AppColors.drawerColor,
       animationCurve: Curves.easeInOut,
        animationDuration: Duration(microseconds: 500),
        openRatio: 0.55,
        openScale: 0.8,
        animateChildDecoration: true,
        childDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
        ),
        //home page code
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                //calling app bar
                appBar(),
                //calling notice board
                SizedBox(height: 15,),
                noticeBoard(),

                //
                SizedBox(height: 25,),
                testSeries(),
              ],
            ),
          ),
        ),
    );
  }

showDrawer(){
    advancedDrawerController.showDrawer();
  }
}

