import 'package:flutter/material.dart';
import 'package:final_flutter/screens/authentication/signin.dart';
import 'package:final_flutter/screens/authentication/signup.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;

  void cambiarVista() => setState(() => showSignIn = !showSignIn);

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignIn(cambiarVista: cambiarVista)
        : SignUp(cambiarVista: cambiarVista);
  }
}
