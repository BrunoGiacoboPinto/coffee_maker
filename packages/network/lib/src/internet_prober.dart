import 'package:environment/environment.dart' as env;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:network/src/http_client_provider.dart';

@lazySingleton
class InternetProber {
  InternetProber(this._httpClientProvider);

  final HttpClientProvider _httpClientProvider;
  late final http.Client client = _httpClientProvider.createClient();

  static Duration get defaultTimeout =>
      const Duration(seconds: env.Environment.probeTimeout);
  static String get defaultEndpoint => env.Environment.probeEndpoint;

  Future<bool> checkOnline({Duration? timeout}) async {
    final effectiveTimeout = timeout ?? defaultTimeout;
    try {
      final response = await client
          .head(Uri.parse(defaultEndpoint))
          .timeout(effectiveTimeout);

      return response.statusCode == 204;
    } on Exception {
      return false;
    }
  }
}
