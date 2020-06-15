import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/models/user.dart';
import 'package:final_flutter/services/auth.dart';
import 'package:final_flutter/services/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../locator.dart';

final databaseReference = Firestore.instance;

class SignUpViewModel extends BaseModel {
  final authService = locator<AuthService>();
  final authProvider = locator<AuthProvider>();

  User get user => authService.user;

  Future signUp(String name, String email, String password) async {
    setState(ViewState.Busy);

    try {
      var user = await authService.signUp(name, email, password);
      await databaseReference.collection("users").document(user.uid).setData({
        'name': user.displayName
      });
      authProvider.setSignedIn();
    } catch (error) {
      throw error;
    }

    notifyListeners();
    setState(ViewState.Idle);
  }

  setToIdle() {
    notifyListeners();
    setState(ViewState.Idle);
  }
}
