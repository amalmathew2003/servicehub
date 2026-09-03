import 'package:service_hub/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:service_hub/features/auth/data/models/user_model.dart';
import 'package:service_hub/features/auth/domain/entities/user_entity.dart';
import 'package:service_hub/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource datasource;
  AuthRepositoryImpl(this.datasource);
  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final credential = await datasource.login(email: email, password: password);

    final user = credential.user;

    if (user == null) {
      throw Exception('login failed');
    }
    return UserModel.fromFirebaseUser(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? "",
    );
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await datasource.register(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw Exception("registeration is failed");
    }
    await user.updateDisplayName(name);
    return UserModel.fromFirebaseUser(
      id: user.uid,
      name: name,
      email: user.email ?? email,
    );
  }

  @override
  Future<void> logout() {
    return datasource.logout();
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return datasource.authStateChanges.map((user) {
      if (user == null) {
        return null;
      }
      return UserModel.fromFirebaseUser(
        id: user.uid,
        email: user.email ?? "",
        name: user.displayName,
      );
    });
  }
}
