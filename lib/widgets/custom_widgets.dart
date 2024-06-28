import 'package:flutter/material.dart';

TextFormField otherField(String text, IconData icon, bool isPassword,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: isPassword == true ? false : true,
    autocorrect: isPassword == true ? false : true,
    cursorHeight: 20.0,
    cursorColor: Colors.black,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your $text';
      }
      return null;
    },
    style: TextStyle(
        color: Colors.black.withOpacity(0.9),
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        height: 1.0),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.blueGrey,
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.3), fontSize: 16.0, height: 1.0),
      filled: true,
      focusedBorder: OutlineInputBorder(
          gapPadding: 1.0,
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.9),
              style: BorderStyle.solid,
              width: 3)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelStyle: const TextStyle(color: Colors.black54),
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          gapPadding: 1.0,
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
              width: 3,
              style: BorderStyle.solid,
              color: Colors.blue.withOpacity(0.9))),
    ),
    keyboardType:
    isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

///This can be used if you want custom but similar login or signup buttons throughout the app.
///You can edit it as desired.
Container loginSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.blueGrey;
            }
            return Colors.blue.shade600;
          }),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
      child: Text(
        isLogin ? 'Log In' : 'Sign Up',
        style: const TextStyle(
            color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}