import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';
import 'package:movies_app/features/authentication/data/models/user_data_model.dart';

abstract class AuthDataSource {
  Future<User?> register(RegisterParameters registerParameters,UserDataModel userDataModel);
  Future<void> addUserToFB(UserDataModel usermodel);
  Future<User?> login(LoginParameters loginParameters);
  Future<void> logout();
  // Future<String> forgotPassword(String email);
}
