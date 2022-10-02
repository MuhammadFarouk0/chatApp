import 'package:authorizing/base/base.dart';
import 'package:authorizing/dialoge_utils.dart';
import 'package:authorizing/ui/login/login_screen.dart';
import 'package:authorizing/ui/registeration/register_viewModel.dart';
import 'package:authorizing/validation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegiserScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegiserScreen> createState() => _RegiserScreenState();
}

class _RegiserScreenState extends BaseState<RegiserScreen,RegisterViewModel>
implements RegisterNavigator{
  bool securedPassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
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
              title: Text('Create Account'),
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
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter full name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Full Name'),
                      ),
                      TextFormField(
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter user name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'User Name'),
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
                            createAccountClicked();
                          },
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(12))),
                          child: Text(
                            'Create Account',
                            style: TextStyle(fontSize: 18),
                          )),
                      TextButton(onPressed: (){
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      }, child: Text('Already Have Account ?')),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
          )),
    );
  }

  var authServis = FirebaseAuth.instance;
  void createAccountClicked() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.register(emailController.text, passwordController.text);
  }
}
