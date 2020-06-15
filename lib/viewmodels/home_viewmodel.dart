import 'package:final_flutter/base/model.dart';
import 'package:final_flutter/services/auth.dart';
import 'package:final_flutter/services/auth_provider.dart';
import 'package:final_flutter/services/lists_service.dart';
import 'package:final_flutter/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../locator.dart';

class HomeViewModel extends BaseModel {
  final authService = locator<AuthService>();
  final authProvider = locator<AuthProvider>();
  final listsService = locator<ListsService>();

  final databaseReference = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  DocumentReference productsList;

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

  updateProductList(List<SelectedProduct> products) async {
    FirebaseUser user = await _auth.currentUser();
    products.forEach((selected) async {
      await databaseReference.collection("users").document(user.uid).collection('products').add({
        'name': selected.product.name,
        'price': selected.product.price,
        'category': selected.product.category,
        'quantity': selected.quantity
      });
    });
  }
}
