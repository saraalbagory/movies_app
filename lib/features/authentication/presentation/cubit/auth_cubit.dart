import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';
import 'package:movies_app/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:movies_app/features/authentication/domain/use_cases/logout_use_case.dart';
import 'package:movies_app/features/authentication/domain/use_cases/registeration_use_case.dart';
import 'package:movies_app/features/authentication/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit(this.loginUseCase, this.registerUseCase, this.logoutUseCase)
      : super(AuthInitial());

  Future<void> login(LoginParameters loginParameters) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(loginParameters);
      emit(Authenticated(user!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(RegisterParameters registerParameters) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(registerParameters);
      emit(Authenticated(user!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(AuthInitial());
  }

}
