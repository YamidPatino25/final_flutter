import 'package:flutter/material.dart';
import 'package:final_flutter/locator.dart';
import 'package:final_flutter/screens/authentication/authentication.dart';
import 'package:final_flutter/screens/home/central.dart';
import 'package:final_flutter/services/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthProvider _authProvider = locator<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _authProvider,
      child: MaterialApp(
          title: 'Shopping app',
          home: Wrapper(),
          theme: ThemeData(
              textTheme: Theme.of(context)
                  .textTheme
                  .apply(fontFamily: 'SanFrancisco'))),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return authProvider.signedIn ? Central() : Authentication();
    });
  }
}
