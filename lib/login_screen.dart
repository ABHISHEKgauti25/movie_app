import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({Key? key,
  required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF21262E),
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF21262E),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(27, 30, 8, 3),
              child: const Text(
                'Email Address',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
            child: TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFCCD8E4),
                hintText: 'Enter your email',
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              controller: email_controller,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(27, 20, 8, 3),
              child: const Text(
                'Password',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
            child: TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFCCD8E4),
                hintText: 'Enter your password',
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: password_controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: ElevatedButton(
                onPressed: signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3C3F41),
                  minimumSize: const Size(360, 50),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF21262E)),
                )),
          ),
         RichText(text: TextSpan(
           text: 'Don\'t have an account?  ',
           style: const TextStyle(color: Colors.white),
           children:  [ TextSpan(
             recognizer: TapGestureRecognizer()
               ..onTap= widget.onClickedSignUp,
             text: 'SignUp',
             style: const TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.bold,
             ),
           ),
    ]
         ),

         )
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context) =>const Center(child: CircularProgressIndicator(),
        )
    );
    
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email_controller.text.trim(),
        password: password_controller.text.trim(),
      );
    } on FirebaseAuthException catch (e)
    {
      print(e);
    }

    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) =>route.isFirst);
  }
}
