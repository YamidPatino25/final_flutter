import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/models/user.dart';
import 'package:final_flutter/services/auth.dart';
import 'package:final_flutter/services/auth_provider.dart';
import '../locator.dart';

class SignInViewModel extends BaseModel {
  final authService = locator<AuthService>();
  final authProvider = locator<AuthProvider>();

  User get user => authService.user;

  Future signIn(String email, String password) async {
    setState(ViewState.Busy);

    try {
      await authService.signIn(email, password);
      authProvider.setSignedIn();
    } catch (error) {
      throw error;
    }

    notifyListeners();
    setState(ViewState.Idle);
  }
}
