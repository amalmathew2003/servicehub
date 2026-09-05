import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_hub/core/error/exceptions.dart';
import 'package:service_hub/features/auth/data/models/user_model.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDatasource(this.firebaseAuth);
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw UnKnownAuthException("Unable to Authenticate user.......");
      }
      return UserModel(
        id: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "Invalid credential":
        case "worng password":
        case "user not found":
          throw const InvalidCredentialsException();
        case "network request failed":
          throw const NetworkException(
            "please chack your internet connection....",
          );
        default:
          throw UnKnownAuthException(e.message ?? 'Authentication failed');
      }
    }
  }

  /// register ///

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw const UnKnownAuthException("Unable to create account ");
      }

      await user.updateDisplayName(name);
      return UserModel(
        id: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email alrady in use":
          throw const EmailAlreadyUseExecption();
        case "week passwrod":
          throw const WeekPasswordExecption();
        case "network request failed":
          throw const NetworkException(
            "please check your internet connection..",
          );
        default:
          throw UnKnownAuthException(e.message ?? "registeration failed");
      }
    }
  }

  Future<void> logout() async {
    return firebaseAuth.signOut();
  }

  Stream<User?> get authStateChanges {
    return firebaseAuth.authStateChanges();
  }

  User? get currentUser {
    return firebaseAuth.currentUser;
  }
}
