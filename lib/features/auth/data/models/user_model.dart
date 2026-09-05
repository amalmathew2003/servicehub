import 'package:service_hub/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });
  factory UserModel.fromFirebaseUser({
    required String id,
    String? name,
    required String email,
  }) {
    return UserModel(id: id, name: name ?? "", email: email);
  }

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      id: data['id']??"",
      name: data['name']??"",
      email: data['email'] ?? "",
    );
  }
}
