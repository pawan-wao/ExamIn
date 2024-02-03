import 'package:examiapp/auth/authbutton.dart';
import 'package:examiapp/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

TextEditingController useremail = TextEditingController();
TextEditingController userPassword = TextEditingController();
TextEditingController userName = TextEditingController();

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // User name
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Text("Name"),
                  prefixIcon: Icon(Icons.phone_android_rounded),
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
                  prefixIcon: Icon(Icons.email_rounded),
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
                  prefixIcon: Icon(Icons.lock_rounded),
                ),
                controller: userPassword,
                validator: (value) {
                  if (value != null) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              AuthButton("SignUp", () => onSignUp(context)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text("Skip"),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

onSignUp(BuildContext context) {
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(
      email: useremail.text.trim(), password: userPassword.text.trim())
      .then((value) {
    // Saving user data on success
    String id = DateTime.now().millisecondsSinceEpoch.toString();


    Map<String, dynamic> emaiUserData = {
      "Name": userName.text,
      "email": useremail.text,
      "password": userPassword.text,
      "Date": DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
      "time": DateFormat('hh:mm a').format(DateTime.now()).toString(),
    };

    final userNode = FirebaseDatabase.instance.ref("USERS/e-mail_users");
    userNode
        .child(id.toString())
        .set(emaiUserData)
        .then((value) {
      print("Data added successfully for ID: $id");
      print("Data saved successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    })
        .catchError((error) {
      print("Error adding data to Firebase: $error");
    });
  }).catchError((error) {
    print("Error creating user: $error");
  });
}
