import 'package:dio/dio.dart';
import 'package:environment/environment.dart' as env;

class InternetProber {
  InternetProber(this._dio);

  final Dio _dio;

  static Duration get defaultTimeout =>
      const Duration(seconds: env.Environment.probeTimeout);
  static String get defaultEndpoint => env.Environment.probeEndpoint;

  Future<bool> checkOnline({Duration? timeout}) async {
    final effectiveTimeout = timeout ?? defaultTimeout;
    try {
      final response = await _dio.head<String>(
        defaultEndpoint,
        options: Options(
          sendTimeout: effectiveTimeout,
          receiveTimeout: effectiveTimeout,
        ),
      );

      return response.statusCode == 204;
    } on Exception {
      return false;
    }
  }
}
