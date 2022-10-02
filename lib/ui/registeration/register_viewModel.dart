import 'package:authorizing/base/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 abstract class RegisterNavigator extends BaseNavigator{

}

class RegisterViewModel extends BaseViewModel<RegisterNavigator>  {
  var auth=FirebaseAuth.instance;
  void register(String email,String password)async{
    navigator?.showloadingDialog();
    try{
      var credentials= await auth.createUserWithEmailAndPassword(email: email, password: password);
      navigator?.hideloadingDialog();
      navigator?.showMessageDialog(credentials.user?.uid ??'');
    }on FirebaseAuthException catch (e) {
      navigator?.hideloadingDialog();
      if(e.code == 'weak-password'){
        navigator?.showMessageDialog('the password provided is weak.');
      }else if(e.code == 'email-already-in-use') {
        navigator?.showMessageDialog('email is already registeerd');
      }
    }catch(e){
      navigator?.hideloadingDialog();
      navigator?.showMessageDialog('somthing went wrong.');

    }
  }
}