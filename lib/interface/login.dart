import 'package:flutter/material.dart';

import '../services/login.dart';
import '../widgets/custom_widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.1, w * 0.05, h * 0.03),
          child: Column(
            children: [
              SizedBox(
                width: w * 0.55,
                height: h * 0.2,
                child: const Icon(Icons.account_circle_outlined),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Card(
                shadowColor: Colors.black,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Login",
                          style:
                          TextStyle(color: Colors.orange.withOpacity(0.4), fontSize: w * 0.09),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        otherField('Email', Icons.person, false,
                            emailControl),
                        const SizedBox(
                          height: 12.0,
                        ),
                        otherField('Enter Password', Icons.lock, true,
                            passControl),
                        const SizedBox(
                          height: 8.0,
                        ),
                        loginSignUpButton(context, true, () {
                          if (_formKey.currentState!.validate()) {
                            emailLogin(emailControl, passControl, emailControl.text, passControl.text, context);
                          }
                        }),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
