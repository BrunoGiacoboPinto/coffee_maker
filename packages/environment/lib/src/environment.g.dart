// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: .env
final class _Environment {
  static const String apiBaseUrl = 'https://api.example.com';

  static const int connectTimeout = 30;

  static const int receiveTimeout = 30;

  static const int probeTimeout = 3;

  static const String probeEndpoint = 'https://www.gstatic.com/generate_204';

  static const List<int> _enviedkeyapiKey = <int>[];

  static const List<int> _envieddataapiKey = <int>[];

  static final String apiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddataapiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]),
  );
}
