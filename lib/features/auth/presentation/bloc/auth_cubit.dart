import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_hub/features/auth/domain/usecases/login_usecase.dart';
import 'package:service_hub/features/auth/domain/usecases/register_usecase.dart';
import 'package:service_hub/features/auth/presentation/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  AuthCubit({required this.loginUsecase, required this.registerUsecase})
    : super(AuthState());

    // login 

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    try {
      final user = await loginUsecase(email: email, password: password);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error, errorMessage: e.toString()),
      );
    }
  }

  // register 

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    try {
      final user = await registerUsecase(
        name: name,
        email: email,
        password: password,
      );
      state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error, errorMessage: e.toString()),
      );
    }
  }

// unauthaticated

  void setunauthenticated() {
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }
}
