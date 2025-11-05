import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PasswordFieldState();
  }
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.visibility_off),
          border: OutlineInputBorder(),
          labelText: 'Password'),
    );
  }
}
