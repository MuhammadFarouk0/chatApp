import 'package:authorizing/base/base.dart';
import 'package:authorizing/dialoge_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class LoginNavigator extends BaseNavigator{

}
class LoginViewModel extends BaseViewModel<LoginNavigator > {

  var auth = FirebaseAuth.instance;

  void login(String email,String password)async{

    try{
      navigator?.showloadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      navigator?.hideloadingDialog();
      navigator?.showMessageDialog(credential.user?.uid ??'');

    }on FirebaseAuthException catch (e) {
      navigator?.hideloadingDialog();
      navigator?.showMessageDialog('wrong user name or password');
    }

  }

}