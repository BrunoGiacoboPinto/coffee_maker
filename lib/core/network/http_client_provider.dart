import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class HttpClientProvider {
  HttpClientProvider();

  http.Client createClient() => http.Client();
}
