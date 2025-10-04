import 'package:dio/dio.dart';
import 'package:environment/environment.dart' as env;
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  ApiClient() : _dio = Dio();

  late final Dio _dio;

  Dio get dio {
    _dio.options = BaseOptions(
      baseUrl: env.Environment.apiBaseUrl,
      connectTimeout: const Duration(seconds: env.Environment.connectTimeout),
      receiveTimeout: const Duration(seconds: env.Environment.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return _dio;
  }
}
