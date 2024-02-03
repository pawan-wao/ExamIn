import 'package:examiapp/auth/phone_Auth/phone_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../pages/homepage.dart';
import '../authbutton.dart';

TextEditingController phoneNumber = TextEditingController();

class OtpScreen extends StatelessWidget{

  String verificationId="";
  String phoneNumber="";
  String userName="";

  OtpScreen({required this.verificationId, required this.phoneNumber, required this.userName});

  TextEditingController smsCode = TextEditingController();

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                label: Text("OTP"),
                prefixIcon: Icon(Icons.phone_android_rounded),
              ),
              controller: smsCode,
              //checking input
              validator: (value) {
                if (value!= null) {
                  return 'Please enter valid mobile number';
                }
                return null;
              },
            ),

            SizedBox(height: 20,),
            AuthButton("Verify OTP",() => onVerify(context,smsCode.text, verificationId, phoneNumber, userName), ),
          ],
        ),
      ),
    );
  }
}

//functions
onVerify(BuildContext context, String smsCode, String verificationId, String phoneNumber, String userName){

  final credential = PhoneAuthProvider.credential(
    smsCode: smsCode,
    verificationId: verificationId,

  );
  try{
    FirebaseAuth.instance.signInWithCredential(credential);

    // saving user details
    saveUser();

    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));

  }catch(e){
    print("${e}");
  }

}


saveUser(){
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  //storing date and time , package used intl
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  String currentTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  final userNode = FirebaseDatabase.instance.ref("USER/phone_User");
  userNode.child(id.toString()).set(userData).then((value) => print("Data added successfully"));

/*
  final usersNode = FirebaseDatabase.instance.ref("User");
  usersNode.child(id.toString()).set({
    "Name": userName.toString(),
    "phone_Number": phoneNumber.toString(),
    "Date": currentDate.toString(),
    "Time": currentTime.toString(),
  }).then((value){
    print("Data saved sucessfully");
  });*/
}