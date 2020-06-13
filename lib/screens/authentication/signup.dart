import 'package:flutter/material.dart';
import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/base/view.dart';
import 'package:final_flutter/shared/loading.dart';
import 'package:final_flutter/viewmodels/signup_viewmodel.dart';

class SignUp extends StatefulWidget {
  final Function cambiarVista;
  SignUp({this.cambiarVista});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Form state
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
        builder: (context, model, child) => Container(
              child: Scaffold(
                  key: _scaffold,
                  appBar: AppBar(title: Text('Registro')),
                  body: Container(
                      margin: EdgeInsets.only(top: 140.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _form,
                          child: Column(children: <Widget>[
                            txtname(),
                            txtemail(),
                            txtpassword(),
                            registerButtom(model),
                            InkWell(
                              onTap: () {
                                widget.cambiarVista();
                              },
                              child: new Padding(
                                padding: new EdgeInsets.all(10.0),
                                child: new Text("Login"),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            model.state == ViewState.Busy
                                ? Loading()
                                : SizedBox()
                          ]),
                        ),
                      ))),
            ));
  }

  Widget registerButtom(SignUpViewModel model) {
    return ButtonTheme(
      child: RaisedButton(
        child: Text(
          'Registrar',
        ),
        onPressed: () async {
          if (_form.currentState.validate()) {
            try {
              await model.signUp(nameController.text, emailController.text,
                  passwordController.text);
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

  Widget txtname() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: 'Ingrese su nombre de usuario aquí',
      ),
      validator: (val) {
        if (val.isEmpty) {
          return 'Nombre no puede estar vacio';
        }
        return null;
      },
    );
  }

  Widget txtemail() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Ingrese su correo electrónico aquí',
      ),
      validator: (val) {
        if (val.isEmpty) {
          return 'No puede estar vacio';
        }
        return null;
      },
    );
  }

  Widget txtpassword() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Ingrese una contraseña',
      ),
      validator: (val) {
        if (val.isEmpty) {
          return 'No puede estar vacia';
        }
        if (val.length < 6) {
          return 'longitud debe ser mayor a 5';
        }
        return null;
      },
    );
  }
}
