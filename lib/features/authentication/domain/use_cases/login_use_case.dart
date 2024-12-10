import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User?> call(LoginParameters loginParameters) async {
    return await repository.login(loginParameters);
  }
}