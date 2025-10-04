import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:coffee_maker/core/network/http_client_provider.dart';
import 'package:coffee_maker/network/cubit/internet_prober.dart';

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
      // Arrange
      when(
        () => mockClient.head(any()),
      ).thenAnswer((_) async => http.Response('', 204));

      // Act
      final result = await prober.checkOnline();

      // Assert
      expect(result, isTrue);
    });

    test('returns false when endpoint responds with non-204 status', () async {
      // Arrange
      when(
        () => mockClient.head(any()),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      final result = await prober.checkOnline();

      // Assert
      expect(result, isFalse);
    });

    test('returns false when request times out', () async {
      // Arrange
      when(() => mockClient.head(any())).thenThrow(Exception('Timeout'));

      // Act
      final result = await prober.checkOnline();

      // Assert
      expect(result, isFalse);
    });

    test('returns false when network error occurs', () async {
      // Arrange
      when(() => mockClient.head(any())).thenThrow(Exception('Network error'));

      // Act
      final result = await prober.checkOnline();

      // Assert
      expect(result, isFalse);
    });

    test('uses custom timeout when provided', () async {
      // Arrange
      const customTimeout = Duration(seconds: 5);
      when(
        () => mockClient.head(any()),
      ).thenAnswer((_) async => http.Response('', 204));

      // Act
      final result = await prober.checkOnline(timeout: customTimeout);

      // Assert
      expect(result, isTrue);
    });

    test('uses injected client', () async {
      // Arrange
      when(
        () => mockClient.head(any()),
      ).thenAnswer((_) async => http.Response('', 204));

      // Act
      await prober.checkOnline();

      // Assert
      verify(() => mockClient.head(any())).called(1);
    });
  });
}
