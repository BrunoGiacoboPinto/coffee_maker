import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('InternetProber', () {
    late InternetProber prober;
    late MockDio mockDio;

    setUpAll(() {
      registerFallbackValue(Uri.parse('https://example.com'));
    });

    setUp(() {
      mockDio = MockDio();
      prober = InternetProber(mockDio);
    });

    test('returns true when endpoint responds with 204', () async {
      when(
        () => mockDio.head<String>(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response<String>(
          statusCode: 204,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await prober.checkOnline();

      expect(result, isTrue);
    });

    test('returns false when endpoint responds with non-204 status', () async {
      when(
        () => mockDio.head<String>(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response<String>(
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await prober.checkOnline();

      expect(result, isFalse);
    });

    test('returns false when request times out', () async {
      when(
        () => mockDio.head<String>(
          any(),
          options: any(named: 'options'),
        ),
      ).thenThrow(Exception('Timeout'));

      final result = await prober.checkOnline();

      expect(result, isFalse);
    });

    test('returns false when network error occurs', () async {
      when(
        () => mockDio.head<String>(
          any(),
          options: any(named: 'options'),
        ),
      ).thenThrow(Exception('Network error'));

      final result = await prober.checkOnline();

      expect(result, isFalse);
    });

    test('uses custom timeout when provided', () async {
      const customTimeout = Duration(seconds: 5);
      when(
        () => mockDio.head<String>(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response<String>(
          statusCode: 204,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await prober.checkOnline(timeout: customTimeout);

      expect(result, isTrue);
    });

    test('uses injected dio', () async {
      when(
        () => mockDio.head<String>(
          any(),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response<String>(
          statusCode: 204,
          requestOptions: RequestOptions(),
        ),
      );

      await prober.checkOnline();

      verify(
        () => mockDio.head<String>(
          any(),
          options: any(named: 'options'),
        ),
      ).called(1);
    });
  });
}
