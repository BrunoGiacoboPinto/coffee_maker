import 'package:coffee_maker/network/cubit/connectivity_cubit.dart';
import 'package:coffee_maker/network/cubit/internet_prober.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetProber extends Mock implements InternetProber {}

void main() {
  group('ConnectivityCubit', () {
    late ConnectivityCubit cubit;
    late MockInternetProber mockProber;

    setUp(() {
      mockProber = MockInternetProber();
      cubit = ConnectivityCubit(mockProber);
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state is online', () {
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
}
