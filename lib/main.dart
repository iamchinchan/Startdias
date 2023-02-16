import 'package:flutter/material.dart';
import 'package:stardias/screens/idea_screen.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth_service.dart';
import 'data/user_model.dart';
import 'screens/authenticate/login_screen.dart';
import 'screens/authenticate/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: null,
      value: AuthService().onAuthStateChanged,
      builder: (context, snapshot) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color(0xffba6e77),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xffba6e77),
            secondary: const Color(0xffa96069),
          ),
          textTheme: const TextTheme().copyWith(
              // bodyText2: TextStyle(color: Colors.red),
              ),
          // primarySwatch: Colors.red,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          IdeaScreen.id: (context) => const IdeaScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegistrationScreen.id: (context) => const RegistrationScreen(),
        },
      ),
    );
  }
}
