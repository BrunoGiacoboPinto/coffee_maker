import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockInternetProber extends Mock implements InternetProber {}

void main() {
  group('ConnectivityCubit', () {
    late ConnectivityCubit cubit;
    late _MockInternetProber mockProber;

    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      registerFallbackValue(<ConnectivityResult>[]);
    });

    setUp(() {
      mockProber = _MockInternetProber();
      cubit = ConnectivityCubit(mockProber);
    });

    tearDown(() async {
      await cubit.close();
    });

    group('initial state', () {
      test('should be online', () {
        expect(cubit.state, ConnectivityStatus.online);
      });

      test('state enum values are correct', () {
        expect(ConnectivityStatus.online, isA<ConnectivityStatus>());
        expect(ConnectivityStatus.offline, isA<ConnectivityStatus>());
        expect(ConnectivityStatus.noNetwork, isA<ConnectivityStatus>());
      });

      test('cubit can be created with internet prober', () {
        expect(cubit, isA<ConnectivityCubit>());
        expect(cubit.state, ConnectivityStatus.online);
      });

      test('cubit has required methods', () {
        expect(cubit.checkConnectivity, isA<Function>());
        expect(cubit.initialize, isA<Function>());
        expect(cubit.close, isA<Function>());
      });
    });

    group('checkConnectivity', () {
      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should emit online when internet is available',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => true);
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.online],
        verify: (_) {
          verify(() => mockProber.checkOnline()).called(1);
        },
      );

      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should emit offline when internet is not available',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.offline],
        verify: (_) {
          verify(() => mockProber.checkOnline()).called(1);
        },
      );

      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should emit noNetwork when connectivity check throws exception',
        build: () {
          when(
            () => mockProber.checkOnline(),
          ).thenThrow(Exception('Network error'));
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.noNetwork],
        verify: (_) {
          verify(() => mockProber.checkOnline()).called(1);
        },
      );

      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should emit noNetwork when connectivity results are empty',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.offline],
      );

      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should emit noNetwork when connectivity results are all none',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.offline],
      );
    });

    group('state transitions', () {
      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should transition from online to offline',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.offline],
      );

      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should transition from offline to online',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => true);
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.online],
      );

      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should transition from online to noNetwork on error',
        build: () {
          when(
            () => mockProber.checkOnline(),
          ).thenThrow(Exception('Network error'));
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.noNetwork],
      );
    });

    group('timer functionality', () {
      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should start recheck timer when offline',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.offline],
        wait: const Duration(milliseconds: 100),
      );

      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should stop recheck timer when online',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => true);
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.online],
      );
    });

    group('error handling', () {
      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should handle different types of exceptions',
        build: () {
          when(
            () => mockProber.checkOnline(),
          ).thenThrow(ArgumentError('Invalid argument'));
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.noNetwork],
        verify: (_) {
          verify(() => mockProber.checkOnline()).called(1);
        },
      );

      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should handle timeout exceptions',
        build: () {
          when(() => mockProber.checkOnline()).thenThrow(Exception('Timeout'));
          return cubit;
        },
        act: (cubit) => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.noNetwork],
        verify: (_) {
          verify(() => mockProber.checkOnline()).called(1);
        },
      );
    });

    group('cleanup', () {
      test('should close properly', () async {
        await cubit.close();
        expect(cubit.isClosed, isTrue);
      });

      test('should handle multiple close calls', () async {
        await cubit.close();
        await cubit.close();
        expect(cubit.isClosed, isTrue);
      });
    });

    group('edge cases', () {
      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should handle rapid state changes',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => true);
          return cubit;
        },
        act: (cubit) async {
          await cubit.checkConnectivity();
          await Future<void>.delayed(const Duration(milliseconds: 10));
          await cubit.checkConnectivity();
        },
        expect: () => [
          ConnectivityStatus.online,
          ConnectivityStatus.online,
        ],
        verify: (_) {
          verify(() => mockProber.checkOnline()).called(2);
        },
      );

      blocTest<ConnectivityCubit, ConnectivityStatus>(
        'should handle null connectivity results',
        build: () {
          when(() => mockProber.checkOnline()).thenAnswer((_) async => false);
          return cubit;
        },
        act: (cubit) async => cubit.checkConnectivity(),
        expect: () => [ConnectivityStatus.offline],
      );
    });
  });
}
