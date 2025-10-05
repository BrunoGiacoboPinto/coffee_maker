import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/src/cubit/internet_prober.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('InternetProber', () {
    late InternetProber internetProber;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      internetProber = InternetProber(mockDio);
    });

    group('default values', () {
      test('should have default timeout and endpoint', () {
        expect(InternetProber.defaultTimeout, const Duration(seconds: 3));
        expect(
          InternetProber.defaultEndpoint,
          'https://www.gstatic.com/generate_204',
        );
      });
    });

    group('checkOnline', () {
      test('returns true when probe succeeds with 204 status', () async {
        final response = Response<String>(
          requestOptions: RequestOptions(),
          statusCode: 204,
        );

        when(
          () => mockDio.head<String>(any(), options: any(named: 'options')),
        ).thenAnswer((_) async => response);

        final result = await internetProber.checkOnline();

        expect(result, isTrue);
        verify(
          () => mockDio.head<String>(
            InternetProber.defaultEndpoint,
            options: any(named: 'options'),
          ),
        ).called(1);
      });

      test('returns false when probe succeeds with non-204 status', () async {
        final response = Response<String>(
          requestOptions: RequestOptions(),
          statusCode: 200,
        );

        when(
          () => mockDio.head<String>(any(), options: any(named: 'options')),
        ).thenAnswer((_) async => response);

        final result = await internetProber.checkOnline();

        expect(result, isFalse);
      });

      test('returns false when probe throws exception', () async {
        when(
          () => mockDio.head<String>(any(), options: any(named: 'options')),
        ).thenThrow(DioException(requestOptions: RequestOptions()));

        final result = await internetProber.checkOnline();

        expect(result, isFalse);
      });

      test('uses custom timeout when provided', () async {
        const customTimeout = Duration(seconds: 5);
        final response = Response<String>(
          requestOptions: RequestOptions(),
          statusCode: 204,
        );

        when(
          () => mockDio.head<String>(any(), options: any(named: 'options')),
        ).thenAnswer((_) async => response);

        await internetProber.checkOnline(timeout: customTimeout);

        final captured = verify(
          () => mockDio.head<String>(
            any(),
            options: captureAny(named: 'options'),
          ),
        ).captured;

        final options = captured.first as Options;
        expect(options.sendTimeout, customTimeout);
        expect(options.receiveTimeout, customTimeout);
      });

      test('uses default timeout when not provided', () async {
        final response = Response<String>(
          requestOptions: RequestOptions(),
          statusCode: 204,
        );

        when(
          () => mockDio.head<String>(any(), options: any(named: 'options')),
        ).thenAnswer((_) async => response);

        await internetProber.checkOnline();

        final captured = verify(
          () => mockDio.head<String>(
            any(),
            options: captureAny(named: 'options'),
          ),
        ).captured;

        final options = captured.first as Options;
        expect(options.sendTimeout, InternetProber.defaultTimeout);
        expect(options.receiveTimeout, InternetProber.defaultTimeout);
      });
    });
  });
}
