import 'package:examiapp/ExamPanel/examPage.dart';
import 'package:examiapp/ExamPanel/resultPage.dart';
import 'package:examiapp/auth/phone_Auth/otpscreen.dart';
import 'package:examiapp/auth/phone_Auth/phone_page.dart';
import 'package:examiapp/widgets/homeScreenWidgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:examiapp/pages/homepage.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.backgrounColor,
        body: PhonePage(),
      ),
    );
  }
}
