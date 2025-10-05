import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_bloc.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_state.dart';
import 'package:coffee_maker/coffee_photo_details/view/coffee_photo_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
      testWidgets(
        'renders CoffeePhotoDetailView loading state',
        tags: TestTag.golden,
        (tester) async {
          tester.setupPathProviderMocks();
          tester.setupDatabaseFactory();
          when(
            () => mockBloc.state,
          ).thenReturn(const CoffeePhotoDetailsState.loading());
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(const CoffeePhotoDetailsState.loading()),
          );

          await tester.pumpAppWithTheme(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(CoffeePhotoDetailView),
            matchesGoldenFile('photo_details_view_loading_light.png'),
          );
        },
      );

      testWidgets(
        'renders CoffeePhotoDetailView success state',
        tags: TestTag.golden,
        (tester) async {
          tester.setupPathProviderMocks();
          tester.setupDatabaseFactory();
          tester.setupDatabaseFactory();
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

          await tester.pumpAppWithTheme(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
            theme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(CoffeePhotoDetailView),
            matchesGoldenFile('photo_details_view_success_light.png'),
          );
        },
      );
    });

    group('dark theme', () {
      testWidgets(
        'renders CoffeePhotoDetailView loading state in dark theme',
        tags: TestTag.golden,
        (tester) async {
          tester.setupPathProviderMocks();
          tester.setupDatabaseFactory();
          tester.setupDatabaseFactory();
          when(
            () => mockBloc.state,
          ).thenReturn(const CoffeePhotoDetailsState.loading());
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(const CoffeePhotoDetailsState.loading()),
          );

          await tester.pumpAppWithTheme(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(CoffeePhotoDetailView),
            matchesGoldenFile('photo_details_view_loading_dark.png'),
          );
        },
      );

      testWidgets(
        'renders CoffeePhotoDetailView success state in dark theme',
        tags: TestTag.golden,
        (tester) async {
          tester.setupPathProviderMocks();
          tester.setupDatabaseFactory();
          tester.setupDatabaseFactory();
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

          await tester.pumpAppWithTheme(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
            darkTheme: ThemeData(useMaterial3: true),
          );

          await expectLater(
            find.byType(CoffeePhotoDetailView),
            matchesGoldenFile('photo_details_view_success_dark.png'),
          );
        },
      );
    });
  });
}
