class ApiResult<T> {
  final T? data;
  final String? message;
  final int? statusCode;
  final bool success;

  ApiResult({
    this.data,
    this.message,
    this.statusCode,
    required this.success,
  });

  factory ApiResult.success(T data, int statusCode) {
    return ApiResult(
      data: data,
      statusCode: statusCode,
      success: true,
    );
  }

  factory ApiResult.failure(String message, int statusCode) {
    return ApiResult(
      message: message,
      statusCode: statusCode,
      success: false,
    );
  }
}