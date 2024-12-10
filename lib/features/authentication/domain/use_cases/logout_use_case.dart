import 'package:movies_app/features/authentication/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future call() async {
    await repository.logout();
  }
}