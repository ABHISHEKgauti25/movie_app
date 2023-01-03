import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp_screen extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUp_screen({Key? key,
  required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUp_screen> createState() => _SignUp_screenState();
}

class _SignUp_screenState extends State<SignUp_screen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController newemail_controller = TextEditingController();
  final TextEditingController newpassword_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF21262E),
      appBar: AppBar(
        title: const Text(
          'SignUp',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF21262E),
      ),
      body: Form(
        key: formKey,
        child: Column(
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
            child: TextFormField(
              style: const TextStyle(color: Color(0xFF4B535B)),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFCCD8E4),
                hintText: 'Enter your email',
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
              email != null && !EmailValidator.validate(email)
                  ? 'enter a valid email'
                  : null,
              controller: newemail_controller,
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
            child: TextFormField(
              obscureText: true,
              style: const TextStyle(color: Color(0xFF4B535B)),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
              value != null && value.length <6
                  ? 'enter min. 6 characters'
                  : null,
              controller: newpassword_controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3C3F41),
                  minimumSize: const Size(360, 50),
                ),
                child: const Text(
                  'SignUp',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF21262E)),
                )),
          ),
          RichText(text: TextSpan(

              text: 'Already have an account?  ',
              style: const TextStyle(color: Colors.white),
              children: [TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap= widget.onClickedSignIn,
                text: 'Log In',
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
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if( !isValid) {
      return;
    }
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context) =>const Center(child: CircularProgressIndicator(),
        )
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: newemail_controller.text.trim(),
        password: newpassword_controller.text.trim(),
      );
    } on FirebaseAuthException catch (e)
    {
      if(e.code == 'weak-password'){
        print('the password provided is too weak');
      }
      else {
        print(e);
      }
    }

    // Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) =>route.isFirst);
  }
}
