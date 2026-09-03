import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:service_hub/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:service_hub/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:service_hub/features/auth/domain/repositories/auth_repository.dart';
import 'package:service_hub/features/auth/domain/usecases/login_usecase.dart';
import 'package:service_hub/features/auth/domain/usecases/register_usecase.dart';
import 'package:service_hub/features/auth/presentation/bloc/auth_cubit.dart';

final getit = GetIt.asNewInstance();
// firebase
void setupDependencies() {
  getit.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //data
  getit.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasource(getit<FirebaseAuth>()),
  );

  getit.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getit<FirebaseAuthDatasource>()),
  );

  //domian

  getit.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(getit<AuthRepository>()),
  );
  getit.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(getit<AuthRepository>()),
  );

  // persentaion
  getit.registerFactory(
    () => AuthCubit(
      loginUsecase: getit<LoginUsecase>(),
      registerUsecase: getit<RegisterUsecase>(),
    ),
  );
}
