import 'package:flutter/material.dart';
import 'package:movie_app/login_screen.dart';
import 'package:movie_app/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin? LoginScreen(onClickedSignUp: toggle,): SignUp_screen(onClickedSignIn : toggle,);
  void toggle() => setState(()
    => isLogin= !isLogin
  );
}
