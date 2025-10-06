import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_bloc.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_state.dart';
import 'package:coffee_maker/coffee_photo_details/view/coffee_photo_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart';

import '../../helpers/helpers.dart';

class MockCoffeePhotoDetailsBloc extends Mock
    implements CoffeePhotoDetailsBloc {}

void main() {
  group('CoffeePhotoDetailView Golden Tests', () {
    late MockCoffeePhotoDetailsBloc mockBloc;

    setUp(() {
      mockBloc = MockCoffeePhotoDetailsBloc();
    });

    group('light theme', () {
      patrolWidgetTest(
        'renders CoffeePhotoDetailView loading state',
        tags: TestTag.golden,
        ($) async {
          $
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(
            () => mockBloc.state,
          ).thenReturn(const CoffeePhotoDetailsState.loading());
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(const CoffeePhotoDetailsState.loading()),
          );

          await $.pumpAppWithTheme(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(CoffeePhotoDetailView),
            matchesGoldenFile('photo_details_view_loading_light.png'),
          );
        },
      );

      patrolWidgetTest(
        'renders CoffeePhotoDetailView success state',
        tags: TestTag.golden,
        ($) async {
          $
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo-id',
            url: 'https://example.com/test-photo.jpg',
            isFavorite: true,
          );
          when(
            () => mockBloc.state,
          ).thenReturn(CoffeePhotoDetailsState.success(photo));
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(CoffeePhotoDetailsState.success(photo)),
          );

          await $.pumpAppWithTheme(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(CoffeePhotoDetailView),
            matchesGoldenFile('photo_details_view_success_light.png'),
          );
        },
      );
    });

    group('dark theme', () {
      patrolWidgetTest(
        'renders CoffeePhotoDetailView loading state in dark theme',
        tags: TestTag.golden,
        ($) async {
          $
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          when(
            () => mockBloc.state,
          ).thenReturn(const CoffeePhotoDetailsState.loading());
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(const CoffeePhotoDetailsState.loading()),
          );

          await $.pumpAppWithTheme(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(CoffeePhotoDetailView),
            matchesGoldenFile('photo_details_view_loading_dark.png'),
          );
        },
      );

      patrolWidgetTest(
        'renders CoffeePhotoDetailView success state in dark theme',
        tags: TestTag.golden,
        ($) async {
          $
            ..setupPathProviderMocks()
            ..setupDatabaseFactory();
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo-id',
            url: 'https://example.com/test-photo.jpg',
            isFavorite: true,
          );
          when(
            () => mockBloc.state,
          ).thenReturn(CoffeePhotoDetailsState.success(photo));
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(CoffeePhotoDetailsState.success(photo)),
          );

          await $.pumpAppWithTheme(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            $(CoffeePhotoDetailView),
            matchesGoldenFile('photo_details_view_success_dark.png'),
          );
        },
      );
    });
  });
}
