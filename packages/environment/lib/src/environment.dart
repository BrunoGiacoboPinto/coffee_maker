import 'package:envied/envied.dart';

part 'environment.g.dart';

/// Environment configuration class that provides access to environment
/// variables and configuration values used throughout the application.
@Envied(path: null, useConstantCase: true)
abstract class Environment {
  /// The base URL for API requests.
  /// Can be configured via API_BASE_URL environment variable.
  @EnviedField(varName: 'API_BASE_URL', defaultValue: 'https://api.example.com')
  static const String apiBaseUrl = _Environment.apiBaseUrl;

  /// Connection timeout in seconds for network requests.
  /// Can be configured via CONNECT_TIMEOUT environment variable.
  @EnviedField(varName: 'CONNECT_TIMEOUT', defaultValue: '30')
  static const int connectTimeout = _Environment.connectTimeout;

  /// Receive timeout in seconds for network requests.
  /// Can be configured via RECEIVE_TIMEOUT environment variable.
  @EnviedField(varName: 'RECEIVE_TIMEOUT', defaultValue: '30')
  static const int receiveTimeout = _Environment.receiveTimeout;

  /// Timeout in seconds for internet connectivity probe requests.
  /// Can be configured via PROBE_TIMEOUT environment variable.
  @EnviedField(varName: 'PROBE_TIMEOUT', defaultValue: '3')
  static const int probeTimeout = _Environment.probeTimeout;

  /// The endpoint URL used for checking internet connectivity.
  /// Can be configured via PROBE_ENDPOINT environment variable.
  @EnviedField(
    varName: 'PROBE_ENDPOINT',
    defaultValue: 'https://www.gstatic.com/generate_204',
  )
  static const String probeEndpoint = _Environment.probeEndpoint;
}
