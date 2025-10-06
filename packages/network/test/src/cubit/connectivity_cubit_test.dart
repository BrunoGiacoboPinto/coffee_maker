import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/src/cubit/connectivity_cubit.dart';
import 'package:network/src/cubit/internet_prober.dart';
import 'package:test/test.dart';

class MockInternetProber extends Mock implements InternetProber {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  group('ConnectivityCubit', () {
    late ConnectivityCubit connectivityCubit;
    late MockInternetProber mockInternetProber;
    late MockConnectivity mockConnectivity;
    late StreamController<List<ConnectivityResult>> connectivityController;

    setUp(() {
      mockInternetProber = MockInternetProber();
      mockConnectivity = MockConnectivity();
      connectivityController = StreamController<List<ConnectivityResult>>();

      when(
        () => mockConnectivity.onConnectivityChanged,
      ).thenAnswer((_) => connectivityController.stream);
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      connectivityCubit = ConnectivityCubit(
        mockInternetProber,
        mockConnectivity,
      );
    });

    tearDown(() async {
      await connectivityController.close();
      await connectivityCubit.close();
    });

    blocTest<ConnectivityCubit, ConnectivityStatus>(
      'emits online when connectivity and internet are available',
      build: () {
        when(
          () => mockInternetProber.checkOnline(),
        ).thenAnswer((_) async => true);
        return connectivityCubit;
      },
      act: (cubit) => cubit.initialize(),
      expect: () => [ConnectivityStatus.online],
    );

    blocTest<ConnectivityCubit, ConnectivityStatus>(
      'emits offline when connectivity available but no internet',
      build: () {
        when(
          () => mockInternetProber.checkOnline(),
        ).thenAnswer((_) async => false);
        return connectivityCubit;
      },
      act: (cubit) => cubit.initialize(),
      expect: () => [ConnectivityStatus.offline],
    );

    blocTest<ConnectivityCubit, ConnectivityStatus>(
      'emits noNetwork when no connectivity',
      build: () {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer((_) async => [ConnectivityResult.none]);
        return connectivityCubit;
      },
      act: (cubit) => cubit.initialize(),
      expect: () => [ConnectivityStatus.noNetwork],
    );
  });
}
