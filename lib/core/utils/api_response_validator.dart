import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../errors/failures.dart';

class ApiResponseValidator {
  /// Validates a response and returns either a [Failure] or the [Response] itself.
  ///
  /// You can provide [validCodes] to customize which status codes are considered
  /// successful (defaults to 200 and 201).
  static Either<Failure, Response<T>> validate<T>(
    Response<T> response, {
    List<int> validCodes = const [200, 201],
  }) {
    final statusCode = response.statusCode;

    if (validCodes.contains(statusCode)) {
      return right(response);
    }

    switch (statusCode) {
      case 400:
        return left(Failure("Bad request. Please check your input parameters."));
      case 401:
        return left(Failure("Unauthorized. Please check your access token."));
      case 403:
        return left(Failure("Forbidden. You might have hit the GitHub rate limit."));
      case 404:
        return left(Failure("The requested resource was not found."));
      case 422:
        return left(Failure("Validation failed. Check your data format."));
      case 500:
        return left(Failure("Internal server error. GitHub might be having issues."));
      case 503:
        return left(Failure("Service unavailable. Please try again later."));
      default:
        if (statusCode != null && statusCode >= 500) {
          return left(Failure("Server error ($statusCode). Please try again later."));
        }
        return left(Failure(response.statusMessage ?? "Unexpected error occurred ($statusCode)"));
    }
  }
}
