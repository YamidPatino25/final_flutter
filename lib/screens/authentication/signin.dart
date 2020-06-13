import 'package:flutter/material.dart';
import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/base/view.dart';

import 'package:final_flutter/shared/loading.dart';
import 'package:final_flutter/viewmodels/signin_viewmodel.dart';

class SignIn extends StatefulWidget {
  final Function cambiarVista;
  SignIn({this.cambiarVista});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Form state
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
      builder: (context, model, child) => Scaffold(
        key: _scaffold,
        appBar: AppBar(
            title: Text(
          'Login',
        )),
        body: Container(
            margin: EdgeInsets.only(top: 140.0),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(children: <Widget>[
                  email(),
                  password(),
                  loginButtom(model),
                  InkWell(
                    onTap: () {
                      widget.cambiarVista();
                    },
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text("Registrar cuenta"),
                    ),
                  ),
                  model.state == ViewState.Busy ? Loading() : SizedBox()
                ]),
              ),
            )),
      ),
    );
  }

  Widget loginButtom(SignInViewModel model) {
    return ButtonTheme(
      child: RaisedButton(
        child: Text(
          'Inicio',
        ),
        onPressed: () async {
          if (_form.currentState.validate()) {
            try {
              await model.signIn(emailController.text, passwordController.text);
            } catch (error) {
              final snackbar = SnackBar(
                content: Text(error.message),
                backgroundColor: Colors.red,
              );
              _scaffold.currentState.showSnackBar(snackbar);
            }
          }
        },
      ),
    );
  }

  Widget email() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Ingrese su correo aquí',
      ),
      validator: (val) {
        if (val.isEmpty) {
          return 'Campo del correo electrónico vacío';
        }
        return null;
      },
    );
  }

  Widget password() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Ingrese su contraseña aquí',
      ),
      validator: (val) {
        if (val.isEmpty) {
          return 'Campo de la contraseña vacío';
        }
        if (val.length < 6) {
          return 'Contraseña debe tener más de 5 caracteres';
        }
        return null;
      },
    );
  }
}
