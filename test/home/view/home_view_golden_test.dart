import 'package:coffee_maker/home/bloc/home_bloc.dart';
import 'package:coffee_maker/home/bloc/home_state.dart';
import 'package:coffee_maker/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  group('HomeView Golden Tests', () {
    late MockHomeBloc mockHomeBloc;

    setUp(() {
      mockHomeBloc = MockHomeBloc();
    });

    setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

    group('light theme', () {
      testWidgets(
        'renders HomeView loading state',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(() => mockHomeBloc.state).thenReturn(const HomeState.loading());
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(const HomeState.loading()));

          await tester.pumpAppWithTheme(
            HomeView(homeBloc: mockHomeBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(HomeView),
            matchesGoldenFile('home_view_loading_light.png'),
          );
        },
      );

      testWidgets(
        'renders HomeView success state with photos',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final photos = TestDataFactory.createMockCoffeePhotoList(count: 4);
          when(() => mockHomeBloc.state).thenReturn(HomeState.success(photos));
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(HomeState.success(photos)));

          await tester.pumpAppWithTheme(
            HomeView(homeBloc: mockHomeBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(HomeView),
            matchesGoldenFile('home_view_success_light.png'),
          );
        },
      );

      testWidgets(
        'renders HomeView success state with empty photos',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final emptyPhotos = TestDataFactory.createEmptyCoffeePhotoList();
          when(
            () => mockHomeBloc.state,
          ).thenReturn(HomeState.success(emptyPhotos));
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(HomeState.success(emptyPhotos)));

          await tester.pumpAppWithTheme(
            HomeView(homeBloc: mockHomeBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(HomeView),
            matchesGoldenFile('home_view_empty_light.png'),
          );
        },
      );

      testWidgets(
        'renders HomeView error state',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(
            () => mockHomeBloc.state,
          ).thenReturn(const HomeState.error('Test error'));
          when(() => mockHomeBloc.stream).thenAnswer(
            (_) => Stream.value(const HomeState.error('Test error')),
          );

          await tester.pumpAppWithTheme(
            HomeView(homeBloc: mockHomeBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(HomeView),
            matchesGoldenFile('home_view_error_light.png'),
          );
        },
      );
    });

    group('dark theme', () {
      testWidgets(
        'renders HomeView loading state in dark theme',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(() => mockHomeBloc.state).thenReturn(const HomeState.loading());
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(const HomeState.loading()));

          await tester.pumpAppWithTheme(
            HomeView(homeBloc: mockHomeBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(HomeView),
            matchesGoldenFile('home_view_loading_dark.png'),
          );
        },
      );

      testWidgets(
        'renders HomeView success state with photos in dark theme',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final photos = TestDataFactory.createMockCoffeePhotoList(count: 4);
          when(() => mockHomeBloc.state).thenReturn(HomeState.success(photos));
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(HomeState.success(photos)));

          await tester.pumpAppWithTheme(
            HomeView(homeBloc: mockHomeBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(HomeView),
            matchesGoldenFile('home_view_success_dark.png'),
          );
        },
      );

      testWidgets(
        'renders HomeView success state with empty photos in dark theme',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final emptyPhotos = TestDataFactory.createEmptyCoffeePhotoList();
          when(
            () => mockHomeBloc.state,
          ).thenReturn(HomeState.success(emptyPhotos));
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(HomeState.success(emptyPhotos)));

          await tester.pumpAppWithTheme(
            HomeView(homeBloc: mockHomeBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(HomeView),
            matchesGoldenFile('home_view_empty_dark.png'),
          );
        },
      );

      testWidgets(
        'renders HomeView error state in dark theme',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(
            () => mockHomeBloc.state,
          ).thenReturn(const HomeState.error('Test error'));
          when(() => mockHomeBloc.stream).thenAnswer(
            (_) => Stream.value(const HomeState.error('Test error')),
          );

          await tester.pumpAppWithTheme(
            HomeView(homeBloc: mockHomeBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(HomeView),
            matchesGoldenFile('home_view_error_dark.png'),
          );
        },
      );
    });
  });
}
