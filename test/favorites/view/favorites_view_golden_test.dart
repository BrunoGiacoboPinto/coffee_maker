import 'package:coffee_maker/favorites/bloc/favorites_bloc.dart';
import 'package:coffee_maker/favorites/bloc/favorites_state.dart';
import 'package:coffee_maker/favorites/view/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart';

import '../../helpers/helpers.dart';

class MockFavoritesBloc extends Mock implements FavoritesBloc {}

void main() {
  group('FavoritesView Golden Tests', () {
    late MockFavoritesBloc mockFavoritesBloc;

    setUp(() {
      mockFavoritesBloc = MockFavoritesBloc();
    });

    group('light theme', () {
      patrolWidgetTest(
        'renders FavoritesView loading state',
        tags: TestTag.golden,
        ($) async {
          $
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(const FavoritesState.loading());
          when(
            () => mockFavoritesBloc.stream,
          ).thenAnswer((_) => Stream.value(const FavoritesState.loading()));

          await $.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(FavoritesView),
            matchesGoldenFile('favorites_view_loading_light.png'),
          );
        },
      );

      patrolWidgetTest(
        'renders FavoritesView success state with photos',
        tags: TestTag.golden,
        ($) async {
          $
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

          await $.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(FavoritesView),
            matchesGoldenFile('favorites_view_success_light.png'),
          );
        },
      );

      patrolWidgetTest(
        'renders FavoritesView success state with empty photos',
        tags: TestTag.golden,
        ($) async {
          $
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final emptyPhotos = TestDataFactory.createEmptyCoffeePhotoList();
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(FavoritesState.success(emptyPhotos));
          when(() => mockFavoritesBloc.stream).thenAnswer(
            (_) => Stream.value(FavoritesState.success(emptyPhotos)),
          );

          await $.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(FavoritesView),
            matchesGoldenFile('favorites_view_empty_light.png'),
          );
        },
      );
    });

    group('dark theme', () {
      patrolWidgetTest(
        'renders FavoritesView loading state in dark theme',
        tags: TestTag.golden,
        ($) async {
          $
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(const FavoritesState.loading());
          when(
            () => mockFavoritesBloc.stream,
          ).thenAnswer((_) => Stream.value(const FavoritesState.loading()));

          await $.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(FavoritesView),
            matchesGoldenFile('favorites_view_loading_dark.png'),
          );
        },
      );

      patrolWidgetTest(
        'renders FavoritesView success state with photos in dark theme',
        tags: TestTag.golden,
        ($) async {
          $
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

          await $.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(FavoritesView),
            matchesGoldenFile('favorites_view_success_dark.png'),
          );
        },
      );

      patrolWidgetTest(
        'renders FavoritesView success state with empty photos in dark theme',
        tags: TestTag.golden,
        ($) async {
          $
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final emptyPhotos = TestDataFactory.createEmptyCoffeePhotoList();
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(FavoritesState.success(emptyPhotos));
          when(() => mockFavoritesBloc.stream).thenAnswer(
            (_) => Stream.value(FavoritesState.success(emptyPhotos)),
          );

          await $.pumpAppWithTheme(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(FavoritesView),
            matchesGoldenFile('favorites_view_empty_dark.png'),
          );
        },
      );
    });
  });
}
