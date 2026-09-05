import 'package:dev_hub/core/params/api_params.dart';
import 'package:dev_hub/shared/data/datasources/local/token_manager.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import 'api_client.dart';
import 'api_interceptor.dart';

class DioClient implements ApiClientInterface {
  final Dio _dio;
  final String _baseURL;
  final TokenManager _tokenManager;

  DioClient({
    required this._dio,
    required this._baseURL,
    required this._tokenManager,
  }) {
    _configureDio();
  }

  void _configureDio() {
    _dio.options.baseUrl = _baseURL;
    _dio.options.connectTimeout = Duration(seconds: 5);
    _dio.options.receiveTimeout = Duration(seconds: 3);
    _dio.interceptors.add(ApiInterceptor(_tokenManager));
  }

  @override
  Future<Either<Failure, Response<dynamic>>> get(ApiParams params) async {
    try {
      final response = await _dio.get(
        params.endpoint,
        queryParameters: params.queryParams,
        options: Options(
          validateStatus: (status) => true, // Don't throw for 404, etc.
        ),
      );
      return right(response);
    } on DioException catch (error) {
      return left(Failure(error.message ?? "Connection error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response<dynamic>>> post(ApiParams params) async {
    try {
      final response = await _dio.post(
        params.endpoint,
        data: params.data,
        options: Options(validateStatus: (status) => true),
      );
      return right(response);
    } on DioException catch (error) {
      return left(Failure(error.message ?? "Connection error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response<dynamic>>> put(ApiParams params) async {
    try {
      final response = await _dio.put(
        params.endpoint,
        data: params.data,
        options: Options(validateStatus: (status) => true),
      );
      return right(response);
    } on DioException catch (error) {
      return left(Failure(error.message ?? "Connection error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response<dynamic>>> delete(ApiParams params) async {
    try {
      final response = await _dio.delete(
        params.endpoint,
        queryParameters: params.queryParams,
        options: Options(validateStatus: (status) => true),
      );
      return right(response);
    } on DioException catch (error) {
      return left(Failure(error.message ?? "Connection error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
