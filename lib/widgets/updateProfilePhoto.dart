
//open dialog option
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class UpdateProfilePhoto{

  Future<void> showImagePicker(BuildContext context) async{
    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Select Image"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    getImageFromGalley();
                  },
                  child: Text("Choose from Gallery"),
                ),
                //more options here
              ],
            ),
          );
        }
    );
  }

//get image from gallery
  Future<void> getImageFromGalley() async{
    File? _image;
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile !=null) {
      _image = File(pickedFile.path);

    }else{
      print('no image selected');
    }

    saveImage(_image!.absolute);

  }

  //save user image to firebase
  saveImage(var _imageAbsolute) async{
    print("SaveImage function started");

    //current user uid
    String? uid = FirebaseAuth.instance.currentUser?.uid.toString();

    //saving to storage and getting url
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('userImages'+'$uid');

    //upload
    firebase_storage.UploadTask uploadTask = ref.putFile(_imageAbsolute);
    await Future.value(uploadTask).then((value){
      print("Image uploaded to firebase Storage");
    }).catchError((error){
      print("Storage error: $error");
    });


    var newUrl = await ref.getDownloadURL();

    //saving url to realtime databse
    final _ref = FirebaseDatabase.instance.ref("Users");
    _ref.child('$uid').update({
      "profileImage": newUrl
    }).then((value){
      print("Dp saved to RD");
    }).catchError((error){
      print("$error");
    });
  }

}

