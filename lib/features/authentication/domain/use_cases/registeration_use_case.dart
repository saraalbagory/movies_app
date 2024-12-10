import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';
import 'package:movies_app/features/authentication/data/models/user_data_model.dart';
import 'package:movies_app/features/authentication/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User?> call(RegisterParameters registationParameters,UserDataModel userDataModel) async {
    return await repository.register( registationParameters,userDataModel);
  }
}