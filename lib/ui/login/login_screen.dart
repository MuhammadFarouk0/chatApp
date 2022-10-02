import 'package:authorizing/base/base.dart';
import 'package:authorizing/dialoge_utils.dart';
import 'package:authorizing/ui/login/login-viewModel.dart';
import 'package:authorizing/ui/registeration/register_screen.dart';
import 'package:authorizing/validation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen,LoginViewModel>
implements LoginNavigator{
  bool securedPassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>viewModel,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background_pattern.png',
                ),
                fit: BoxFit.fill),
          ),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text('Login'),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.all(12),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter email';
                          }
                          if (!ValidationUtils.isValidEmail(text)) {
                            return 'please enter a valid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter password';
                          }
                          if (text.length < 6) {
                            return 'password must be at least 6 digits';
                          }
                          return null;
                        },
                        obscureText: securedPassword,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: InkWell(
                                onTap: () {
                                  securedPassword = !securedPassword;
                                  setState(() {});
                                },
                                child: Icon(securedPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            signIn();
                          },
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(12))),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          )),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, RegiserScreen.routeName);
                      }, child: Text('or create Account')),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
          )),
    );
  }

  void signIn() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
viewModel.login(emailController.text, passwordController.text);
  }
}
