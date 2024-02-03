import 'package:cached_network_image/cached_network_image.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/app_elevations.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:flutter/material.dart';
import '../../utils/roughwork.dart';

// app bar of the app
String imgProfileUrl = 'https://media.istockphoto.com/id/1435745704/photo/portrait-of-smiling-mid-adult-businessman-standing-at-corporate-office.jpg?s=612x612&w=0&k=20&c=NtTebZxpAfw964hJJut8WFa__eZEfO07CAKdqeFBrFU=';

Widget appBar(){
  return Material(
    elevation: AppElevations.appBarElevation,
    child: Container(
      color: AppColors.appBarBackground,
      child: Padding(
        padding: AppPadding.sidePadding,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.dashboard),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: CachedNetworkImageProvider(
                    imgProfileUrl
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
          ],
        ),
      ),
    ),
  );
}