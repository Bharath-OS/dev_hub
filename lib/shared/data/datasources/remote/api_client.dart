import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/params/api_params.dart';

abstract interface class ApiClientInterface {
  Future<Either<Failure, Response<dynamic>>> get(ApiParams params);

  Future<Either<Failure, Response<dynamic>>> post(ApiParams params);

  Future<Either<Failure, Response<dynamic>>> put(ApiParams params);

  Future<Either<Failure, Response<dynamic>>> patch(ApiParams params);

  Future<Either<Failure, Response<dynamic>>> delete(ApiParams params);
}
