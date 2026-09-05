import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_hub/core/error/exceptions.dart';
import 'package:service_hub/features/auth/data/models/user_model.dart';

class FirebaseUserDatasoure {
  final FirebaseFirestore firestore;
  FirebaseUserDatasoure(this.firestore);

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    try {
      await firestore.collection('users').doc(uid).set({
        'id': uid,
        "name": name,
        "email": email,
        "role": "customer",
        'createAt': FieldValue.serverTimestamp(),
        "updateAt": FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw FirestoreException(e.message ?? "Failed to create user profile ");
    }
  }

  /// get the user profile
  ///
  Future<UserModel> getUserProfile({required String uid}) async {
    try {
      final document = await firestore.collection('user').doc(uid).get();
      if (!document.exists) {
        throw const FirestoreException("user profile is not found");
      }
      final data = document.data();
      if (data == null) {
        throw const FirestoreException("User profile data is empty");
      }
      return UserModel.fromFirestore(data);
    } on FirebaseException catch (e) {
      throw FirestoreException(e.message ?? "Failed to get user profile");
    }
  }
}
