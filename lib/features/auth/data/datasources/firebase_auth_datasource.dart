import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_hub/features/auth/data/models/user_model.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDatasource(this.firebaseAuth);
  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> register({
    required String email,
    required String password,
  }) {
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async{
    return firebaseAuth.signOut();
  }

  Stream<User?> get authStateChanges{
    return firebaseAuth.authStateChanges();
  }

  User? get currentUser{
    return firebaseAuth.currentUser;
  }
}
