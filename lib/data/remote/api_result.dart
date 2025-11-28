/// A sealed class representing the result of an API operation.
///
/// This allows for type-safe handling of success and failure cases without
/// relying on exceptions for control flow.
sealed class ApiResult<T> {
  const ApiResult();
}

/// Represents a successful API operation containing data of type [T].
class Success<T> extends ApiResult<T> {
  final T data;

  const Success(this.data);
}

/// Represents a failed API operation containing an error message and optional status code.
class Failure<T> extends ApiResult<T> {
  final String message;
  final int? statusCode;
  final dynamic data;

  const Failure(this.message, {this.statusCode, this.data});
}
