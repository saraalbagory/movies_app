import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/authentication/data/data_source/auth_data_source.dart';
import 'package:movies_app/features/authentication/data/data_source/auth_data_source_impl.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';
import 'package:movies_app/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthDataSource _authDataSource =AuthDataSourceImpl();

  @override
  Future<User?> login(LoginParameters loginParameters)async {
     return await _authDataSource.login(loginParameters);
  }

  @override
  Future logout() async{
   return await _authDataSource.logout();
  }

  @override
  Future<User?> register(RegisterParameters registerParameters)async {
   return await _authDataSource.register(registerParameters);
  }

}