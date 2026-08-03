import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failures.dart';
import '../../../core/params/api_params.dart';

abstract interface class ApiClient {
  Future<Either<Failure, dynamic>> get(ApiParams params);

  Future<Either<Failure, dynamic>> post(ApiParams params);
}