
import 'package:examiapp/auth/email_auth/signup.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/spinKit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../pages/homepage.dart';
import '../../utils/padding.dart';
import '../authbutton.dart';
import '../squarebox.dart';

TextEditingController useremail = TextEditingController();
TextEditingController userPassword = TextEditingController();

bool loading = false;

class SignIn extends StatefulWidget{
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context){
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
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
                      Text("PalciPrep", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Hi! welcome to ExamIn", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text("SignIn to your account", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightText, fontSize: 15),),
                  SizedBox(height: 40,),
                  Text("Enter your details:", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightText, fontSize: 15),),
                  SizedBox(height: 10,),

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

                  SizedBox(height: 10,),
                  //to reset password
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: (){
                          resetPasswordDialog(context);
                        },
                        child: Text("Reset password",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.lightText),)),
                  ),

                  SizedBox(height: 50),

                  //submit, next button
                  Center(child:
                  loading == false ?
                  AuthButton("SignIn", () => onSignIn(context)):

                      //loading widget from utils
                      SpinKit(),
                  ),

                  SizedBox(height: 15,),
                  //already signed in text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text("Create a Account ? "),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                          },
                          child: Text("SignUp",style: TextStyle(fontWeight: FontWeight.bold),)),
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

  //forget password
  Future<void> resetPasswordDialog(BuildContext context) async{
    TextEditingController resetEmail = TextEditingController();
    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Enter Details:"),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  //take user email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.alternate_email_rounded,color: AppColors.iconColors,),
                    ),
                    controller: resetEmail,
                    validator: (value) {
                      if (value != null) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: (){
                      FirebaseAuth.instance.sendPasswordResetEmail(email: resetEmail.text).then((value) => {
                        //on sucess
                      Navigator.pop(context),
                      print("Password reset email send on email")
                      }).catchError((error){
                        print("error");
                      });
                    },
                    child: Text("Reset Password"),
                  ),
                  //more options here
                ],
              ),
            )
          );
        }
    );
  }

  //onSignIn function
  onSignIn(BuildContext context) {
    setState(() {
      loading = true;
    });

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: useremail.text,
        password: userPassword.text,
    ).then((value) {
      //on sucess go to home page
      setState(() {
        loading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
    }).catchError((error){
      setState(() {
        loading = false;
      });
      print("$error");
    });
  }
}