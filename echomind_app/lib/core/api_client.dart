import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:echomind_app/shared/utils/error_brief.dart';

class ApiClient {
  static const _baseUrl = 'http://8.130.16.212:8001/api';
  static const _tokenKey = 'auth_token';
  static final ValueNotifier<String?> latestError =
      ValueNotifier<String?>(null);

  static final ApiClient _instance = ApiClient._();
  factory ApiClient() => _instance;

  late final Dio dio;

  ApiClient._() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
      ),
    );
    dio.interceptors.add(_AuthInterceptor());
    dio.interceptors.add(_ErrorInterceptor());
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(ApiClient._tokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = switch (err.type) {
      DioExceptionType.connectionTimeout => 'Connection timeout',
      DioExceptionType.receiveTimeout => 'Receive timeout',
      DioExceptionType.badResponse => _parseServerError(err.response),
      DioExceptionType.connectionError => 'Cannot connect to server',
      _ => 'Network error: ${err.message}',
    };

    if (kDebugMode) {
      final method = err.requestOptions.method;
      final path = err.requestOptions.path;
      final code = err.response?.statusCode;
      debugPrint('[API ERROR] $method $path code=$code message=$message');
      final body = err.response?.data;
      if (body != null) {
        debugPrint('[API ERROR BODY] $body');
      }
    }

    final method = err.requestOptions.method;
    final path = err.requestOptions.path;
    final brief = briefError(err);
    ApiClient.latestError.value = 'Endpoint: $method $path\n$brief';

    handler.next(err.copyWith(message: message));
  }

  String _parseServerError(Response<dynamic>? response) {
    if (response == null) return 'Server error';
    final data = response.data;
    if (data is Map && data.containsKey('detail')) {
      return data['detail'].toString();
    }
    return 'Server error (${response.statusCode})';
  }
}
