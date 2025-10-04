import 'package:envied/envied.dart';

part 'environment.g.dart';

@Envied(path: null, useConstantCase: true)
abstract class Environment {
  @EnviedField(varName: 'API_BASE_URL', defaultValue: 'https://api.example.com')
  static const String apiBaseUrl = _Environment.apiBaseUrl;

  @EnviedField(varName: 'CONNECT_TIMEOUT', defaultValue: '30')
  static const int connectTimeout = _Environment.connectTimeout;

  @EnviedField(varName: 'RECEIVE_TIMEOUT', defaultValue: '30')
  static const int receiveTimeout = _Environment.receiveTimeout;

  @EnviedField(varName: 'PROBE_TIMEOUT', defaultValue: '3')
  static const int probeTimeout = _Environment.probeTimeout;

  @EnviedField(
    varName: 'PROBE_ENDPOINT',
    defaultValue: 'https://www.gstatic.com/generate_204',
  )
  static const String probeEndpoint = _Environment.probeEndpoint;

  @EnviedField(varName: 'API_KEY', obfuscate: true, defaultValue: '')
  static final String apiKey = _Environment.apiKey;
}
