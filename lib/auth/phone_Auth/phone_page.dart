import 'package:examiapp/auth/email_auth/signup.dart';
import 'package:examiapp/auth/phone_Auth/otpscreen.dart';
import 'package:examiapp/pages/homepage.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:examiapp/auth/authbutton.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

TextEditingController phoneNumber = TextEditingController();
TextEditingController userName = TextEditingController();
TextEditingController countryCode = TextEditingController(text: '+91');

bool loading = false;

class PhonePage extends StatefulWidget {
  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.sidePadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70,),
            // Display
            Row(
              children: [
                Icon(Icons.chat_bubble, color: Colors.lightBlueAccent,),
                SizedBox(width: 12,),
                Text("ExamIn", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Name",
                prefixIcon: Icon(Icons.person, color: AppColors.iconColors,),
              ),
              controller: userName,
              // Checking input
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid Name';
                }
                return null;
              },
            ),
            // Row of country code & phone number
            SizedBox(height: 15,),

            Row(
              children: [
                // Country code
                Container(
                  width: 80, // Adjust the width as needed
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: countryCode,
                      // Checking input
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid code';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // Phone number
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Mobile Number",
                        prefixIcon: Icon(Icons.phone_android_rounded),
                      ),
                      controller: phoneNumber,
                      // Checking input
                      validator: (value) {
                        if (value == null || value.length != 10) {
                          return 'Please enter a valid 10-digit mobile number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),

            //submit, next button
            Center(child:
                loading == false ?
            AuthButton("Next", () => onNext(context),):
                SpinKitThreeBounce(
                  color: AppColors.iconColors, // Customize the color
                  size: 40.0,
                  duration: Duration(milliseconds: 1000),// Customize the size
                ),
            ),

            SizedBox(height: 50,),
            //skip & choose e-Mail
            Row(
              children: [
                // Skip button
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text("Skip"),
                ),
                Spacer(),
                // Go with e-Mail button
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text("Go with e-Mail"),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}

onNext(BuildContext context) {
  setState(() {
    loading = true;
  });
  FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: countryCode.text+phoneNumber.text,
    verificationCompleted: (_) {},
    verificationFailed: (e) {
      print("${e}");
    },
    codeSent: (String verificationId, int? token) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            verificationId: verificationId,
            phoneNumber: phoneNumber.text,
            userName: userName.text,
          ),
        ),
      );
    },
    codeAutoRetrievalTimeout: (e) {
      print("${e}");
    },
  );
}

Map<String, dynamic> userData = {
  "Name": userName.text,
  "phoneNumber": phoneNumber.text,
  // Add more key-value pairs as needed
};
