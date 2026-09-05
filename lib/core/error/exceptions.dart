class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class InvalidCredentialsException implements Exception {
  const InvalidCredentialsException();
}

class UserNotFoundExecption implements Exception {
  const UserNotFoundExecption();
}

class EmailAlreadyUseExecption implements Exception {
  const EmailAlreadyUseExecption();
}

class WeekPasswordExecption implements Exception {
  const WeekPasswordExecption();
}

class UnKnownAuthException implements Exception {
  final String message;
  const UnKnownAuthException(this.message);
}

class FirestoreException implements Exception {
  final String message;
  const FirestoreException(this.message);
}
