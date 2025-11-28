# Networking Layer Guide

This guide explains how to use the refactored networking layer in the AirNav Helpdesk app.

## Key Features

- **Result Pattern**: Type-safe success/failure handling
- **Custom Exceptions**: Structured error information
- **Configurable Error Display**: Control over automatic snackbars
- **Timeouts**: 30s default timeouts for all requests

## Making API Requests

### 1. Using the Result Pattern (Recommended)

Wrap your API calls in a repository or service to return `ApiResult<T>`.

```dart
Future<ApiResult<User>> login(String email, String password) async {
  try {
    final response = await apiClient.dio.post(
      Endpoints.login,
      data: {'email': email, 'password': password},
    );
    
    return Success(User.fromJson(response.data));
  } on DioException catch (e) {
    // The interceptor might have already shown a snackbar
    return Failure(
      e.message ?? 'Unknown error',
      statusCode: e.response?.statusCode,
      data: e.response?.data,
    );
  } catch (e) {
    return Failure(e.toString());
  }
}
```

### 2. Handling Results in UI/Controller

```dart
final result = await authRepository.login(email, password);

switch (result) {
  case Success(data: final user):
    // Handle success
    Get.toNamed(Routes.HOME);
    break;
  case Failure(message: final msg):
    // Handle failure (optional, since snackbar might have shown)
    print('Login failed: $msg');
    break;
}
```

## Disabling Automatic Error Snackbars

If you want to handle errors manually without the default snackbar, add the `X-Show-Errors: false` header.

```dart
final response = await apiClient.dio.get(
  '/api/status',
  options: Options(
    headers: {'X-Show-Errors': 'false'},
  ),
);
```

## Error Handling

The `ApiException` class provides structured access to error details:

- `message`: User-friendly error message
- `statusCode`: HTTP status code (e.g., 400, 401, 500)
- `data`: Raw error response data

## Dependency Injection

The `ApiClient` is now injectable. In your bindings:

```dart
Get.lazyPut<ApiClient>(() => ApiClient());
```

In your repositories/services:

```dart
class AuthRepository {
  final ApiClient _apiClient = Get.find<ApiClient>();
  // ...
}
```
