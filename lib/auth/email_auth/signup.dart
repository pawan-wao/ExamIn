import 'package:examiapp/auth/authbutton.dart';
import 'package:examiapp/auth/email_auth/signIn.dart';
import 'package:examiapp/auth/phone_Auth/phone_page.dart';
import 'package:examiapp/main.dart';
import 'package:examiapp/pages/homepage.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:examiapp/pages/appDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/spinKit.dart';
import '../squarebox.dart';

TextEditingController useremail = TextEditingController();
TextEditingController userPassword = TextEditingController();
TextEditingController userName = TextEditingController();

bool loading = false;

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.backgrounColor,
        body: SafeArea(
          child: Padding(
            padding: AppPadding.sidePadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //skip this page --> home page
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      child: Text("Skip",style: TextStyle(color: AppColors.iconColors, fontSize: 15,),),
                    ),
                  ),

                  SizedBox(height: 40,),
                  // Display
                  Row(
                    children: [
                      Icon(Icons.chat_bubble, color: Colors.lightBlueAccent,),
                      SizedBox(width: 12,),
                      Text("PlaciPrep", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Hi! welcome to ExamIn", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text("Create your account", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightText, fontSize: 15),),
                  SizedBox(height: 40,),
                  Text("Enter your details:", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightText, fontSize: 15),),
                  SizedBox(height: 10,),
                  // User name
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text("Name"),
                      prefixIcon: Icon(Icons.phone_android_rounded,color: AppColors.iconColors,),
                    ),
                    controller: userName,
                    validator: (value) {
                      if (value != null) {
                        return 'Please enter a valid Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.alternate_email_rounded,color: AppColors.iconColors,),
                    ),
                    controller: useremail,
                    validator: (value) {
                      if (value != null) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // User Password
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text("Password"),
                      prefixIcon: Icon(Icons.password_rounded,color: AppColors.iconColors,),
                    ),
                    controller: userPassword,
                    validator: (value) {
                      if (value != null) {
                        return 'Please enter a valid password';
                      }
                      if (value!.length <= 5) {
                        return 'Atleast 6 characters required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50),

                  //submit, next button
                  Center(child:
                   loading == false ?
                   AuthButton("SignUp", () => onSignUp(context)):

                   //loading widget from utils
                   SpinKit(),
                  ),
                  SizedBox(height: 20,),

                  //already signed in text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                    Text("Already have a Account ? "),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(),));
                        },
                        child: Text("SignIn",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ],
                  ),

                  SizedBox(height: 40,),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  //skip & choose e-Mail
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20,),
                      // Go with e-Mail button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: SquareBox(Icons.phone),
                      ),

                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onSignUp(BuildContext context) {
    setState(() {
      loading = true;
    });

    //creating user
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: useremail.text.trim(), password: userPassword.text.trim())
        .then((value) {

      // Saving user data on success
      Map<String, dynamic> userDataEmail = {
        "Name": userName.text,
        "email": useremail.text,
        "password": userPassword.text,
        "Date": DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
        "time": DateFormat('hh:mm a').format(DateTime.now()).toString(),
        "profileImage": "https://firebasestorage.googleapis.com/v0/b/examiapp-4a318.appspot.com/o/userImagessxWP4pBMW1ccdGkaIJQOzkQLfVK2?alt=media&token=1e17e5a5-1ec5-40f9-bbec-9ec65d81d",
      };

      //getting user uid
      String? uid = FirebaseAuth.instance.currentUser?.uid.toString();

      final userNode = FirebaseDatabase.instance.ref("Users");
      userNode
          .child(uid.toString())
          .set(userDataEmail)
          .then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        setState(() {
          loading = false;
        });
      })
          .catchError((error) {
        print("Error adding data to Firebase: $error");
        setState(() {
          loading = false;
        });
      });
    }).catchError((error) {
      print("Error creating user: $error");
      setState(() {
        loading = false;
      });
    });
  }
}

