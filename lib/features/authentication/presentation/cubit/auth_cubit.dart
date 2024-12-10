import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';
import 'package:movies_app/features/authentication/data/models/user_data_model.dart';
import 'package:movies_app/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:movies_app/features/authentication/domain/use_cases/logout_use_case.dart';
import 'package:movies_app/features/authentication/domain/use_cases/registeration_use_case.dart';
import 'package:movies_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:movies_app/support/resources/locators/api_locator.dart';

class AuthCubit extends Cubit<AuthState> {
  late final LoginUseCase loginUseCase;
  late final RegisterUseCase registerUseCase;
  late final LogoutUseCase logoutUseCase;

  AuthCubit() : super(AuthInitial()){loginUseCase = LoginUseCase(ApiLocator.authRepository);
   registerUseCase = RegisterUseCase(ApiLocator.authRepository);
   logoutUseCase = LogoutUseCase(ApiLocator.authRepository);
   }

  Future<void> login(LoginParameters loginParameters) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(loginParameters);
      emit(Authenticated(user!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(RegisterParameters registerParameters,UserDataModel userDataModel) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(registerParameters,userDataModel);
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
