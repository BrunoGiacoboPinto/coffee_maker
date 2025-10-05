import 'package:coffee_maker/favorites/bloc/favorites_bloc.dart';
import 'package:coffee_maker/favorites/bloc/favorites_state.dart';
import 'package:coffee_maker/favorites/view/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockFavoritesBloc extends Mock implements FavoritesBloc {}

void main() {
  group('FavoritesView Golden Tests', () {
    late MockFavoritesBloc mockFavoritesBloc;

    setUp(() {
      mockFavoritesBloc = MockFavoritesBloc();
    });

    group('light theme', () {
      testWidgets(
        'renders FavoritesView loading state',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(const FavoritesState.loading());
          when(
            () => mockFavoritesBloc.stream,
          ).thenAnswer((_) => Stream.value(const FavoritesState.loading()));

          await tester.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(FavoritesView),
            matchesGoldenFile('favorites_view_loading_light.png'),
          );
        },
      );

      testWidgets(
        'renders FavoritesView success state with photos',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final photos = TestDataFactory.createMockCoffeePhotoList(
            allFavorites: true,
          );
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(FavoritesState.success(photos));
          when(
            () => mockFavoritesBloc.stream,
          ).thenAnswer((_) => Stream.value(FavoritesState.success(photos)));

          await tester.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(FavoritesView),
            matchesGoldenFile('favorites_view_success_light.png'),
          );
        },
      );

      testWidgets(
        'renders FavoritesView success state with empty photos',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final emptyPhotos = TestDataFactory.createEmptyCoffeePhotoList();
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(FavoritesState.success(emptyPhotos));
          when(() => mockFavoritesBloc.stream).thenAnswer(
            (_) => Stream.value(FavoritesState.success(emptyPhotos)),
          );

          await tester.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(FavoritesView),
            matchesGoldenFile('favorites_view_empty_light.png'),
          );
        },
      );
    });

    group('dark theme', () {
      testWidgets(
        'renders FavoritesView loading state in dark theme',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(const FavoritesState.loading());
          when(
            () => mockFavoritesBloc.stream,
          ).thenAnswer((_) => Stream.value(const FavoritesState.loading()));

          await tester.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(FavoritesView),
            matchesGoldenFile('favorites_view_loading_dark.png'),
          );
        },
      );

      testWidgets(
        'renders FavoritesView success state with photos in dark theme',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final photos = TestDataFactory.createMockCoffeePhotoList(
            allFavorites: true,
          );
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(FavoritesState.success(photos));
          when(
            () => mockFavoritesBloc.stream,
          ).thenAnswer((_) => Stream.value(FavoritesState.success(photos)));

          await tester.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(FavoritesView),
            matchesGoldenFile('favorites_view_success_dark.png'),
          );
        },
      );

      testWidgets(
        'renders FavoritesView success state with empty photos in dark theme',
        tags: TestTag.golden,
        (tester) async {
          tester
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final emptyPhotos = TestDataFactory.createEmptyCoffeePhotoList();
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(FavoritesState.success(emptyPhotos));
          when(() => mockFavoritesBloc.stream).thenAnswer(
            (_) => Stream.value(FavoritesState.success(emptyPhotos)),
          );

          await tester.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(FavoritesView),
            matchesGoldenFile('favorites_view_empty_dark.png'),
          );
        },
      );
    });
  });
}
