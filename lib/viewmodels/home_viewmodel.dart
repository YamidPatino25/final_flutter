import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/services/auth.dart';
import 'package:final_flutter/services/auth_provider.dart';
import 'package:final_flutter/services/lists_service.dart';
import 'package:final_flutter/shared/constants.dart';
import '../locator.dart';

class HomeViewModel extends BaseModel {
  final authService = locator<AuthService>();
  final authProvider = locator<AuthProvider>();
  final listsService = locator<ListsService>();

  List<SelectedProduct> get selectedProducts => listsService.userList;

  addProductToCart(SelectedProduct selectedProduct) {
    if (selectedProduct != null) {
      listsService.userList.add(selectedProduct);
    }
    notifyListeners();
  }

  removeProduct(int position) {
    listsService.userList.removeAt(position);
    notifyListeners();
  }

  Future logout() async {
    setState(ViewState.Busy);
    await authService.signOut();
    authProvider.logout();
    setState(ViewState.Idle);
  }
}
