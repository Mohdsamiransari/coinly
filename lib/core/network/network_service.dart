import 'dart:developer';

import 'package:coinly/core/network/api_endpoints.dart';
import 'package:coinly/core/network/api_result.model.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_api;

class NetworkService<T> {
  final Dio _dio;

  NetworkService()
      : _dio = Dio(BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
        )) {
    // Optionally add interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // You can add logs here for debugging or manipulate the request
        log("Request: ${options.method} ${options.uri}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Log the response data
        log("Response: ${response.statusCode} ${response.data}");
        return handler.next(response);
      },
      onError: (error, handler) {
        // Handle error globally (e.g., logging or adding extra error details)
        log("Error: ${error.message}");
        return handler.next(error);
      },
    ));
  }

  Future<ApiResult<T>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    bool withAuth = true,
    required T Function(dynamic) parse,
  }) async {
    try {
      var response = await _dio.get(url,
          queryParameters: queryParameters,
          options: _withAuthHeader(withAuth: withAuth));

      final parsedData = parse(response.data);
      return handleStatusCode(response: response, parsedData: parsedData);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  Future<ApiResult<T>> post(
    String url, {
    dynamic data,
    bool withAuth = true,
    required T Function(dynamic) parse,
  }) async {
    try {
      var response = await _dio.post(url,
          data: data, options: _withAuthHeader(withAuth: withAuth));
      final parsedData = parse(response.data);

      return handleStatusCode(response: response, parsedData: parsedData);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  Future<ApiResult<T>> put(
    String url, {
    dynamic data,
    bool withAuth = true,
    required T Function(dynamic) parse,
  }) async {
    try {
      dio_api.Response response = await _dio.put(url,
          data: data, options: _withAuthHeader(withAuth: withAuth));
      final parsedData = parse(response.data);
      return handleStatusCode(response: response, parsedData: parsedData);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  Future<ApiResult<T>> delete(
    String url, {
    dynamic data,
    bool withAuth = true,
    required Function(dynamic) parse,
  }) async {
    try {
      var response = await _dio.delete(url,
          data: data, options: _withAuthHeader(withAuth: withAuth));
      final parsedData = parse(response.data);

      return handleStatusCode(response: response, parsedData: parsedData);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  ApiResult<T> handleStatusCode({required response, T? parsedData}) {
    switch (response.statusCode) {
      case 200:
        return ApiResult<T>.success(parsedData as T, response.statusCode!);

      case 201:
        return ApiResult<T>.success(parsedData as T, response.statusCode!);
      // case 204:
      //   return ApiResult.success( null, 204); // No content
      case 400:
        return ApiResult<T>.failure("Bad Request", 400);
      case 401:
        return ApiResult<T>.failure("Unauthorized", 401);
      case 403:
        return ApiResult<T>.failure("Forbidden", 403);
      case 404:
        return ApiResult<T>.failure("Not Found", 404);
      case 409:
        return ApiResult<T>.failure("Conflict", 409);
      case 422:
        return ApiResult<T>.failure("Unprocessable Entity", 422);
      case 500:
        return ApiResult<T>.failure("Internal Server Error", 500);
      case 503:
        return ApiResult<T>.failure("Service Unavailable", 503);
      default:
        return ApiResult<T>.failure(
            "Unexpected Error", response.statusCode ?? 0);
    }
  }

  String _getAuthToken() {
    // Fetch token from secure storage or any global source.
    return "Bearer your_token_here";
  }

  Options _withAuthHeader({bool withAuth = true}) {
    final header = {
      'Content-Type': 'application/json',
      if (withAuth) 'Authorization': _getAuthToken(),
    };
    return Options(
      headers: header,
      validateStatus: (status) => true,
    );
  }

  ApiResult<T> handleError(DioException e) {
    // Handle connection errors (e.g., no internet connection)
    if (e.type == DioExceptionType.connectionError &&
        e.message!.contains('SocketException')) {
      return ApiResult.failure("No internet connection", 0);
    }

    // Handle timeouts
    if (e.type == DioExceptionType.connectionTimeout) {
      return ApiResult.failure("Connection timeout", 0);
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      return ApiResult.failure("Receive timeout", 0);
    }

    // Handle other Dio exceptions
    if (e.response != null) {
      log("Dio Error: ${e.response?.statusCode} - ${e.message}");
      final statusCode = e.response?.statusCode ?? 0;
      final message = e.response?.data['message'] ??
          e.message ??
          "Unknown Dio error"; // Enhanced error message
      return ApiResult.failure(message, statusCode);
    }

    // If no specific error type matches
    log("Dio Error: ${e.message}");
    return ApiResult.failure("Unexpected Error", 0);
  }

  // Optional
  Future<ApiResult<T>> retryRequest(Future<ApiResult<T>> Function() request,
      {int retries = 3, int delaySeconds = 2}) async {
    int attempts = 0;
    while (attempts < retries) {
      try {
        return await request();
      } catch (e) {
        attempts++;
        if (attempts >= retries) {
          return ApiResult.failure("Max retry attempts reached", 0);
        }
        await Future.delayed(Duration(seconds: delaySeconds));
      }
    }
    return ApiResult.failure("Unexpected Error", 0);
  }
}