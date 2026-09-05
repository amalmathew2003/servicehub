abstract class Failures {
  final String message;

  const Failures(this.message);
}

class InvalidCredentialsFailure extends Failures {
  const InvalidCredentialsFailure() : super("Invalid email or password");
}

class UserNotFoundFailure extends Failures {
  const UserNotFoundFailure() : super("user not found");
}

class EmailAlreadyInUseFailure extends Failures {
  const EmailAlreadyInUseFailure() : super("This email already used");
}

class WeakPasswordFailure extends Failures {
  const WeakPasswordFailure() : super("the password is too week");
}

class NetworkFailure extends Failures {
  const NetworkFailure() : super("please check your internet connection");
}

class ServerFailure extends Failures {
  const ServerFailure() : super("something want wrong .please try again");
}

class UnknownFailure extends Failures {
  const UnknownFailure() : super("Something went wrong. Please try again");
}

class FirestoreFailure extends Failures {
  const FirestoreFailure(super.message);
}
