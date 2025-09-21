import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/firebase/firebasefuntions.dart';
import 'package:to_do_app/models/user_model.dart';

class ProviderAuth extends ChangeNotifier{
  late User? firebaseuser;
  Usermodel? usermodel;

  ProviderAuth(){
    firebaseuser=FirebaseAuth.instance.currentUser;

    if(firebaseuser != null){
      inituser();
    }
  }

  inituser() async{
   usermodel=await FireBaseFunctions.readuser();
    notifyListeners();
  }
}