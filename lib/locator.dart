import 'package:get_it/get_it.dart';
import 'package:final_flutter/services/auth.dart';
import 'package:final_flutter/services/auth_provider.dart';
import 'package:final_flutter/services/lists_service.dart';
import 'package:final_flutter/viewmodels/friends_viewmodel.dart';
import 'package:final_flutter/viewmodels/home_viewmodel.dart';
import 'package:final_flutter/viewmodels/signin_viewmodel.dart';
import 'package:final_flutter/viewmodels/signup_viewmodel.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => ListsService());
  locator.registerFactory(() => SignInViewModel());
  locator.registerFactory(() => SignUpViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => FriendsViewModel());
}
