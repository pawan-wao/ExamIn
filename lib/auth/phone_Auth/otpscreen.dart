import 'package:examiapp/auth/phone_Auth/phone_page.dart';
import 'package:examiapp/utils/appColors.dart';
import 'package:examiapp/utils/padding.dart';
import 'package:examiapp/utils/spinKit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../pages/homepage.dart';
import '../authbutton.dart';

TextEditingController phoneNumber = TextEditingController();
bool loading = false;

class OtpScreen extends StatefulWidget{

  String verificationId="";
  String phoneNumber="";
  String userName="";

  OtpScreen({required this.verificationId, required this.phoneNumber, required this.userName});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController smsCode = TextEditingController();

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.sidePadding,
          child: Column(
            children: [
              SizedBox(height: 70,),
              Text("Verify Phone",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Text("Code has been sent to ${widget.phoneNumber}",style: TextStyle(color: AppColors.lightText),),
              SizedBox(height: 40,),
              //otp text field
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: Text("6 Digit code"),
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

              SizedBox(height: 50,),

              loading==false?
              AuthButton("Verify OTP",() => onVerify(context,smsCode.text, widget.verificationId, widget.phoneNumber, widget.userName), ):

                  //loading kit from utils
              SpinKit(),
            ],
          ),
        ),
      ),
    );
  }
  //functions
  onVerify(BuildContext context, String smsCode, String verificationId, String phoneNumber, String userName){

    setState(() {
      loading=true;
    });
    final credential = PhoneAuthProvider.credential(
      smsCode: smsCode,
      verificationId: verificationId,);
    try{
      FirebaseAuth.instance.signInWithCredential(credential).then((value){
        setState(() {
          loading=true;
        });
        //on sucess code
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        // saving user details
        saveUser();
        setState(() {
          loading=false;
        });
      }).catchError((error){
        setState(() {
          loading=false;
        });
        print("$error");
      });





    }catch(e){
      print("${e}");
    }
  }

}



saveUser(){
  String? uid = FirebaseAuth.instance.currentUser?.uid.toString();

  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  String currentTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  final userNode = FirebaseDatabase.instance.ref("Users");
  userNode.child(uid.toString()).set(userDataPhone)
      .then((value) => print("Data added successfully"))
      .catchError((error){
        print("$error");
      });


}