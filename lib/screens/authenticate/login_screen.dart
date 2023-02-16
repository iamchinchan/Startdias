import 'package:flutter/material.dart';
import 'package:stardias/services/auth_service.dart';
import '../../components/round_button.dart';
import '../../constants/constants.dart';
import '../../components/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'authenticate_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const id = 'login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showSpinner = false;
  String? email;
  String? password;

  @override
  void initState() {
    print('login page created right now!');
    super.initState();
  }

  @override
  void deactivate() {
    print('login page deactivated');
    super.deactivate();
  }

  @override
  void dispose() {
    print('login page disposed , totally gone');
    super.dispose();
  }

// declared the formKey as a field in our Login State object
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'appLogo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              Form(
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CustomTextField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some email text';
                        }
                        return null;
                      },
                      // value: email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      hintText: 'Enter your email',
                      color: primaryButtonColor,
                      icon: Icons.email,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some password text';
                        }
                        return null;
                      },
                      // value: password,
                      obscureText: true,
                      onChanged: (value) {
                        //Do something with the user input.
                        password = value;
                      },
                      hintText: 'Enter your password',
                      color: primaryButtonColor,
                      icon: Icons.password,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    RoundButton(
                      onPressed: () async {
                        //Implement login functionality.
                        setState(() {
                          showSpinner = true;
                        });
                        if (_loginFormKey.currentState!.validate()) {
                          final user = await AuthService()
                              .loginWithEmailPassword(
                                  email: email!, password: password!);
                          if (user != null) {
                            print(
                                'User successfully logged in with value: $user');
                            Navigator.pop(context);
                          } else {
                            emailController.clear();
                            passwordController.clear();
                            print(
                                'Log in with email and password failed, please try again later');
                          }
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                      color: primaryButtonColor,
                      label: 'Log In',
                    ),
                  ],
                ),
              ),
              RoundButton(
                onPressed: () async {
                  //Implement login functionality.
                  setState(() {
                    showSpinner = true;
                  });
                  final user = await AuthService().signInAnonymously();
                  if (user != null) {
                    print('User successfully logged in with value: $user');
                    Navigator.pop(context);
                  } else {
                    print('Anonymous login failed, please try again later');
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
                color: primaryButtonColor,
                label: 'Log In Anonymously',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
