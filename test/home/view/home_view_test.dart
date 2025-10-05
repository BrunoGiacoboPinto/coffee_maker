import 'package:coffee_maker/home/bloc/home_bloc.dart';
import 'package:coffee_maker/home/bloc/home_event.dart';
import 'package:coffee_maker/home/bloc/home_state.dart';
import 'package:coffee_maker/home/view/home_page.dart';
import 'package:coffee_maker/widgets/coffee_photo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/helpers.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  group('HomeView', () {
    late MockHomeBloc mockHomeBloc;

    setUp(() {
      mockHomeBloc = MockHomeBloc();
    });

    group('rendering', () {
      testWidgets(
        'renders HomeView for HomeInitialState',
        (tester) async {
          when(() => mockHomeBloc.state).thenReturn(const HomeState.initial());
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(const HomeState.initial()));

          await tester.pumpApp(
            HomeView(homeBloc: mockHomeBloc),
          );

          expect(find.byType(Shimmer), findsOneWidget);
          expect(find.byType(GridView), findsOneWidget);
        },
      );

      testWidgets(
        'renders HomeView for HomeLoadingState',
        (tester) async {
          when(() => mockHomeBloc.state).thenReturn(const HomeState.loading());
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(const HomeState.loading()));

          await tester.pumpApp(
            HomeView(homeBloc: mockHomeBloc),
          );

          expect(find.byType(Shimmer), findsOneWidget);
          expect(find.byType(GridView), findsOneWidget);
        },
      );

      testWidgets(
        'renders HomeView for HomeSuccessState with photos',
        (tester) async {
          final photos = TestDataFactory.createMockCoffeePhotoList();
          when(() => mockHomeBloc.state).thenReturn(HomeState.success(photos));
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(HomeState.success(photos)));

          await tester.pumpApp(
            HomeView(homeBloc: mockHomeBloc),
          );

          expect(find.byType(CoffeePhotoCard), findsNWidgets(3));
          // Note: Shimmer widgets are present because CachedNetworkImage shows placeholder when network fails in tests
          expect(find.byType(Shimmer), findsNWidgets(3));
        },
      );

      testWidgets(
        'renders HomeView for HomeSuccessState with empty photos',
        (tester) async {
          final emptyPhotos = TestDataFactory.createEmptyCoffeePhotoList();
          when(
            () => mockHomeBloc.state,
          ).thenReturn(HomeState.success(emptyPhotos));
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(HomeState.success(emptyPhotos)));

          await tester.pumpApp(
            HomeView(homeBloc: mockHomeBloc),
          );

          expect(find.byType(CoffeePhotoCard), findsNothing);
          expect(find.byType(GridView), findsOneWidget);
          expect(find.byType(Shimmer), findsNothing);
        },
      );

      testWidgets(
        'renders HomeView for HomeErrorState',
        (tester) async {
          when(
            () => mockHomeBloc.state,
          ).thenReturn(const HomeState.error('Test error'));
          when(() => mockHomeBloc.stream).thenAnswer(
            (_) => Stream.value(const HomeState.error('Test error')),
          );

          await tester.pumpApp(
            HomeView(homeBloc: mockHomeBloc),
          );

          expect(find.byType(SizedBox), findsOneWidget);
          expect(find.byType(CoffeePhotoCard), findsNothing);
          expect(find.byType(Shimmer), findsNothing);
        },
      );
    });

    group('interactions', () {
      testWidgets(
        'adds ToggleFavoriteEvent when favorite icon is tapped',
        (tester) async {
          final photos = TestDataFactory.createSingleCoffeePhotoList();
          when(() => mockHomeBloc.state).thenReturn(HomeState.success(photos));
          when(
            () => mockHomeBloc.stream,
          ).thenAnswer((_) => Stream.value(HomeState.success(photos)));

          await tester.pumpAppWithRouter(
            HomeView(homeBloc: mockHomeBloc),
          );

          // Use patrol finders for more precise interaction
          final favoriteIcon = find.byIcon(Icons.favorite_border);
          await tester.tap(favoriteIcon);
          await tester.pump();

          verify(
            () => mockHomeBloc.add(
              const HomeEvent.toggleFavorite('single-photo'),
            ),
          ).called(1);
        },
      );
    });

    group('state transitions', () {
      testWidgets(
        'transitions from loading to success state',
        (tester) async {
          final photos = TestDataFactory.createMockCoffeePhotoList(count: 2);
          when(() => mockHomeBloc.state).thenReturn(const HomeState.loading());
          when(() => mockHomeBloc.stream).thenAnswer(
            (_) => Stream.fromIterable([
              const HomeState.loading(),
              HomeState.success(photos),
            ]),
          );

          await tester.pumpApp(
            HomeView(homeBloc: mockHomeBloc),
          );

          // Initial state should show shimmer
          expect(find.byType(Shimmer), findsOneWidget);

          // Wait for state transition
          await tester.pump(const Duration(seconds: 1));

          // Success state should show photos
          expect(find.byType(CoffeePhotoCard), findsNWidgets(2));
          // Note: Shimmer widgets are present because CachedNetworkImage shows placeholder when network fails in tests
          expect(find.byType(Shimmer), findsNWidgets(2));
        },
      );
    });
  });
}
