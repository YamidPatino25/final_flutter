import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/models/user.dart';
import 'package:final_flutter/services/auth.dart';
import 'package:final_flutter/services/auth_provider.dart';
import '../locator.dart';

class SignUpViewModel extends BaseModel {
  final authService = locator<AuthService>();
  final authProvider = locator<AuthProvider>();

  User get user => authService.user;

  Future signUp(String name, String email, String password) async {
    setState(ViewState.Busy);

    try {
      await authService.signUp(name, email, password);
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
