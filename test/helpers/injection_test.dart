import 'package:coffee_maker/core/network/api_client.dart';
import 'package:coffee_maker/di/injection.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockDio extends Mock implements Dio {}

class MockInternetProber extends Mock implements InternetProber {}

class MockConnectivityCubit extends Mock implements ConnectivityCubit {}

class MockHttpClientProvider extends Mock implements HttpClientProvider {}

class MockApiClient extends Mock implements ApiClient {}

Future<void> configureTestDependencies() async {
  await getIt.reset();

  getIt
    ..registerLazySingleton<HttpClientProvider>(MockHttpClientProvider.new)
    ..registerLazySingleton<ApiClient>(MockApiClient.new)
    ..registerLazySingleton<InternetProber>(MockInternetProber.new)
    ..registerFactory<ConnectivityCubit>(MockConnectivityCubit.new);
}

Future<void> resetTestDependencies() async {
  await getIt.reset();
}
