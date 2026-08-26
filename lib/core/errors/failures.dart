class Failure implements Exception{
  final String message;

  Failure([this.message = "Unexpected error occurred"]);

  @override
  String toString() => message;
}

class AuthFailure extends Failure{
  AuthFailure(super.message);
}

class LogFailure extends Failure{
  LogFailure(super.message);
}