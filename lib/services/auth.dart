import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_flutter/models/user.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  User user;

  User userFromFb(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, email: user.email, name: user.displayName)
        : null;
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      user = userFromFb(res.user);
    } catch (error) {
      throw error;
    }
  }

  Future<FirebaseUser> signUp(String name, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = await _auth.currentUser();

      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = name;

      await user.updateProfile(updateInfo);
      await user.reload();

      return await _auth.currentUser();
    } catch (error) {
      throw error;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
