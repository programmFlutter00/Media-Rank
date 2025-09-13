import 'package:dio/dio.dart';
import 'package:media_rank/core/constants/api_constants.dart';

/// HTTP client for API communication
class ApiClient {
  late final Dio _dio;

  static ApiClient? _instance;

  /// Singleton instance
  static ApiClient get instance {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  ApiClient._internal() {
    _dio = Dio();
    _initializeClient();
  }

  /// Initialize the HTTP client with configuration
  void _initializeClient() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors for logging and error handling
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          // Only log in debug mode
          // print(object);
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add any request modifications here
          handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle successful responses
          handler.next(response);
        },
        onError: (error, handler) {
          // Handle errors globally
          _handleError(error);
          handler.next(error);
        },
      ),
    );
  }

  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        // Handle timeout errors
        break;
      case DioExceptionType.badResponse:
        // Handle HTTP errors
        break;
      case DioExceptionType.cancel:
        // Handle request cancellation
        break;
      case DioExceptionType.unknown:
        // Handle unknown errors
        break;
      default:
        break;
    }
  }

  Dio get dio => _dio;
}
