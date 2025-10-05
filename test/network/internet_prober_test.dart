import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHttpClientProvider extends Mock implements HttpClientProvider {}

void main() {
  group('InternetProber', () {
    late InternetProber prober;
    late MockHttpClient mockClient;
    late MockHttpClientProvider mockProvider;

    setUpAll(() {
      registerFallbackValue(Uri.parse('https://example.com'));
    });

    setUp(() {
      mockClient = MockHttpClient();
      mockProvider = MockHttpClientProvider();
      when(() => mockProvider.createClient()).thenReturn(mockClient);
      prober = InternetProber(mockProvider);
    });

    test('returns true when endpoint responds with 204', () async {
      when(
        () => mockClient.head(any()),
      ).thenAnswer((_) async => http.Response('', 204));

      final result = await prober.checkOnline();

      expect(result, isTrue);
    });

    test('returns false when endpoint responds with non-204 status', () async {
      when(
        () => mockClient.head(any()),
      ).thenAnswer((_) async => http.Response('', 200));

      final result = await prober.checkOnline();

      expect(result, isFalse);
    });

    test('returns false when request times out', () async {
      when(() => mockClient.head(any())).thenThrow(Exception('Timeout'));

      final result = await prober.checkOnline();

      expect(result, isFalse);
    });

    test('returns false when network error occurs', () async {
      when(() => mockClient.head(any())).thenThrow(Exception('Network error'));

      final result = await prober.checkOnline();

      expect(result, isFalse);
    });

    test('uses custom timeout when provided', () async {
      const customTimeout = Duration(seconds: 5);
      when(
        () => mockClient.head(any()),
      ).thenAnswer((_) async => http.Response('', 204));

      final result = await prober.checkOnline(timeout: customTimeout);

      expect(result, isTrue);
    });

    test('uses injected client', () async {
      when(
        () => mockClient.head(any()),
      ).thenAnswer((_) async => http.Response('', 204));

      await prober.checkOnline();

      verify(() => mockClient.head(any())).called(1);
    });
  });
}
