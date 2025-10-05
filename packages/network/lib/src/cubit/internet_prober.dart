import 'package:dio/dio.dart';
import 'package:environment/environment.dart' as env;

/// A utility class for checking internet connectivity by probing a
/// remote endpoint.
/// Uses HTTP HEAD requests to determine if the device has actual
/// internet access.
class InternetProber {
  /// Creates an [InternetProber] with the given [Dio] client.
  InternetProber(this._dio);

  final Dio _dio;

  /// The default timeout duration for connectivity probe requests.
  /// Gets the timeout value from environment configuration.
  static Duration get defaultTimeout =>
      const Duration(seconds: env.Environment.probeTimeout);

  /// The default endpoint URL used for connectivity probes.
  /// Gets the endpoint URL from environment configuration.
  static String get defaultEndpoint => env.Environment.probeEndpoint;

  /// Checks if the device has internet connectivity by making a HEAD
  /// request to the probe endpoint. Returns `true` if the request succeeds
  /// with status 204.
  ///
  /// The [timeout] parameter allows overriding the default timeout duration.
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
