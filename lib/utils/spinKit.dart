//spinkit function
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'appColors.dart';

Widget SpinKit() {
  return SpinKitThreeBounce(
    color: AppColors.iconColors, // Customize the color
    size: 20.0,
    duration: Duration(milliseconds: 1000), // Customize the size
  );
}

Widget ProfileSpinKit() {
  return SpinKitRotatingCircle(
    color: AppColors.iconColors,
// Customize the color
    size: 20.0,
    duration: Duration(
        milliseconds: 1000), // Customize the size
  );

}