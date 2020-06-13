import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/services/auth.dart';
import 'package:final_flutter/services/auth_provider.dart';
import '../locator.dart';

class FriendsViewModel extends BaseModel {
  final authService = locator<AuthService>();
  final authProvider = locator<AuthProvider>();

  Future logout() async {
    setState(ViewState.Busy);
    await authService.signOut();
    authProvider.logout();
    setState(ViewState.Idle);
  }
}
