class Failure {
  final String message;

  Failure([this.message = "Unexpected error occured"]);

  @override
  String toString() => message;
}

class AuthFailure extends Failure{
  AuthFailure(super.message);
}

class LoggFailure extends Failure{
  LoggFailure(super.message);
}