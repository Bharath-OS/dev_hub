import 'dart:convert';
import 'package:dev_hub/core/params/api_params.dart';
import 'package:dev_hub/data/datasources/remote/api_interceptor.dart';
import 'package:dev_hub/presentation/auth/data/datasource/local/auth_local_database_interface.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failures.dart';
import 'api_client.dart';

class DioClient implements ApiClientInterface {
  final Dio _dio;
  final String _baseURL;
  final AuthLocalDatabaseInterface _localDB;

  DioClient({required this._dio, required this._baseURL,required this._localDB}) {
    _configureDio();
  }

  void _configureDio() {
    _dio.options.baseUrl = _baseURL;
    _dio.options.connectTimeout = Duration(seconds: 5);
    _dio.options.receiveTimeout = Duration(seconds: 3);
    _dio.interceptors.add(ApiInterceptor(_localDB));
  }

  @override
  Future<Either<Failure, dynamic>> get(ApiParams params) async {
    try {
      final response = await _dio.get(
        params.endpoint,
        queryParameters: params.queryParams,
        options: Options(
          headers: params.accessToken.isNotEmpty
              ? {"Authorization": "token ${params.accessToken}"}
              : null,
        ),
      );
      return _verifyResponse(response);
    } on DioException catch (error) {
      if (error.response != null) {
        return _verifyResponse(error.response!);
      }
      return left(Failure(error.message ?? "Connection error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> post(ApiParams params) async {
    try {
      final response = await _dio.post(
        params.endpoint,
        data: params.data,
        options: Options(
          headers: params.accessToken.isNotEmpty
              ? {"Authorization": "token ${params.accessToken}"}
              : null,
        ),
      );
      return _verifyResponse(response);
    } on DioException catch (error) {
      if (error.response != null) {
        return _verifyResponse(error.response!);
      }
      return left(Failure(error.message ?? "Connection error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Either<Failure, dynamic> _verifyResponse(Response response) {
    final statusCode = response.statusCode;
    final data = response.data;

    if (statusCode == 200 || statusCode == 201) {
      if (data is String && data.isNotEmpty) {
        try {
          return right(jsonDecode(data));
        } catch (_) {
          return right(data);
        }
      }
      return right(data);
    }

    Failure failure;
    switch (statusCode) {
      case 400:
        failure = Failure("Bad request. Please check your input parameters.");
        break;
      case 401:
        failure = Failure("Unauthorized. Please check your access token.");
        break;
      case 403:
        failure = Failure("Forbidden. You might have hit the GitHub rate limit.");
        break;
      case 404:
        failure = Failure("The requested resource was not found.");
        break;
      case 422:
        failure = Failure("Validation failed. Check your data format.");
        break;
      case 500:
        failure = Failure("Internal server error. GitHub might be having issues.");
        break;
      case 503:
        failure = Failure("Service unavailable. Please try again later.");
        break;
      default:
        if (statusCode != null && statusCode >= 500) {
          failure = Failure("Server error ($statusCode). Please try again later.");
        } else {
          failure = Failure(
            response.statusMessage ?? "Unexpected error occurred ($statusCode)",
          );
        }
    }
    return left(failure);
  }
}
