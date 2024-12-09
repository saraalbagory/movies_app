import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';

abstract class AuthRepository {
    Future<User?> register(RegisterParameters registerParameters);
    Future<User?> login(LoginParameters loginParameters);
    Future<void> logout();
}