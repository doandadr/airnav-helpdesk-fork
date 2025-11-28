/// Custom exception class for API-related errors.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() =>
      'ApiException(message: $message, statusCode: $statusCode, data: $data)';
}
