import 'package:flutter/material.dart';
import 'package:stardias/data/user_model.dart';
import 'package:stardias/screens/authenticate/authenticate_screen.dart';
import 'package:provider/provider.dart';
import 'package:stardias/screens/idea_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel?>(context);
    if (userModel == null) {
      print('showing Authenticate screen as user is null');
      return const AuthenticateScreen();
    } else {
      print(
          'showing ideaScreen screen as user is not null ans uid is: ${userModel.uid}');
      return const IdeaScreen();
    }
  }
}
