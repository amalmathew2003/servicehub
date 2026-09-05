import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_hub/core/error/failures.dart';
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
    final result = await loginUsecase(email: email, password: password);
    result.fold(
      (failures) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: failures.message,
          ),
        );
      },
      (user) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      },
    );
  }

  // register

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    final result = await registerUsecase(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (failures) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: failures.message,
          ),
        );
      },
      (user) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      },
    );
  }

  // unauthaticated

  void setunauthenticated() {
    emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
  }
}
