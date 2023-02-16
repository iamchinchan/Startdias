import 'package:flutter/material.dart';
import 'package:stardias/screens/authenticate/authenticate_screen.dart';
import '../../components/custom_text_field.dart';
import '../../components/round_button.dart';
import '../../constants/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const id = 'registration_screen';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  String email = '';
  String password = '';

  @override
  void initState() {
    print('registration page state object created!');
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('registration object deactivated');
  }

  @override
  void dispose() {
    super.dispose();
    print('registration object disposed');
  }

  final _registerFormkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                key: _registerFormkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CustomTextField(
                      // value: email,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some email text';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      hintText: 'Enter your email',
                      color: secondaryButtonColor,
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomTextField(
                      // value: password,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some password text';
                        }
                        return null;
                      },
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      hintText: 'Enter your password',
                      color: secondaryButtonColor,
                      icon: Icons.password,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    RoundButton(
                        onPressed: () async {
                          //Implement registration functionality.
                          setState(() {
                            showSpinner = true;
                          });
                          if (_registerFormkey.currentState!.validate()) {
                            final newUser = await AuthService()
                                .registerWithEmailPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              print('new user created with values: $newUser');
                              Navigator.pop(context);
                            } else {
                              emailController.clear();
                              passwordController.clear();
                              print('Failed to create new user! Try again');
                            }
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        color: secondaryButtonColor,
                        label: 'Register'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
