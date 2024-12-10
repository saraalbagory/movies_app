import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';

abstract class AuthDataSource {
  Future<User?> register(RegisterParameters registerParameters);
  Future<User?> login(LoginParameters loginParameters);
  Future logout();
  // Future<String> forgotPassword(String email);
}
