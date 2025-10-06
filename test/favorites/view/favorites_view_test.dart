import 'package:coffee_maker/favorites/bloc/favorites_bloc.dart';
import 'package:coffee_maker/favorites/bloc/favorites_event.dart';
import 'package:coffee_maker/favorites/bloc/favorites_state.dart';
import 'package:coffee_maker/favorites/view/favorites_page.dart';
import 'package:coffee_maker/widgets/coffee_photo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/helpers.dart';

class MockFavoritesBloc extends Mock implements FavoritesBloc {}

void main() {
  group('FavoritesPage', () {
    late MockFavoritesBloc mockFavoritesBloc;

    setUp(() {
      mockFavoritesBloc = MockFavoritesBloc();
    });

    testWidgets(
      'renders FavoritesPage',
      (tester) async {
        when(
          () => mockFavoritesBloc.state,
        ).thenReturn(const FavoritesState.initial());
        when(
          () => mockFavoritesBloc.stream,
        ).thenAnswer((_) => Stream.value(const FavoritesState.initial()));

        await tester.pumpApp(
          FavoritesPage(favoritesBloc: mockFavoritesBloc),
        );

        expect(find.byType(FavoritesView), findsOneWidget);
      },
    );
  });

  group('FavoritesView', () {
    late MockFavoritesBloc mockFavoritesBloc;

    setUp(() {
      mockFavoritesBloc = MockFavoritesBloc();
    });

    group('rendering', () {
      testWidgets(
        'renders FavoritesView for FavoritesInitialState',
        (tester) async {
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(const FavoritesState.initial());
          when(
            () => mockFavoritesBloc.stream,
          ).thenAnswer((_) => Stream.value(const FavoritesState.initial()));

          await tester.pumpApp(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
          );

          expect(find.byType(Shimmer), findsOneWidget);
          expect(find.byType(ListView), findsOneWidget);
        },
      );

      testWidgets(
        'renders FavoritesView for FavoritesSuccessState with photos',
        (tester) async {
          final photos = TestDataFactory.createMockCoffeePhotoList(
            allFavorites: true,
          );
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(FavoritesState.success(photos));
          when(
            () => mockFavoritesBloc.stream,
          ).thenAnswer((_) => Stream.value(FavoritesState.success(photos)));

          await tester.pumpApp(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
          );

          expect(find.byType(CoffeePhotoCard), findsNWidgets(3));
          expect(find.byType(Shimmer), findsNWidgets(3));
          expect(find.text('No favorites yet'), findsNothing);
        },
      );

      testWidgets(
        'renders FavoritesView for FavoritesSuccessState with empty photos',
        (tester) async {
          final emptyPhotos = TestDataFactory.createEmptyCoffeePhotoList();
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(FavoritesState.success(emptyPhotos));
          when(() => mockFavoritesBloc.stream).thenAnswer(
            (_) => Stream.value(FavoritesState.success(emptyPhotos)),
          );

          await tester.pumpApp(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
          );

          expect(find.byType(CoffeePhotoCard), findsNothing);
          expect(find.text('No favorites yet'), findsOneWidget);
          expect(find.byIcon(Icons.favorite_border), findsOneWidget);
          expect(find.byType(Shimmer), findsNothing);
        },
      );

      testWidgets(
        'renders FavoritesView for FavoritesErrorState',
        (tester) async {
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(const FavoritesState.error('Test error'));
          when(() => mockFavoritesBloc.stream).thenAnswer(
            (_) => Stream.value(const FavoritesState.error('Test error')),
          );

          await tester.pumpApp(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
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
          final photos = TestDataFactory.createSingleCoffeePhotoList(
            isFavorite: true,
          );
          when(
            () => mockFavoritesBloc.state,
          ).thenReturn(FavoritesState.success(photos));
          when(
            () => mockFavoritesBloc.stream,
          ).thenAnswer((_) => Stream.value(FavoritesState.success(photos)));

          await tester.pumpAppWithRouter(
            FavoritesView(favoritesBloc: mockFavoritesBloc),
          );
          final favoriteIcon = find.byIcon(Icons.favorite);
          await tester.tap(favoriteIcon);
          await tester.pump();

          verify(
            () => mockFavoritesBloc.add(
              const FavoritesEvent.toggleFavorite('single-photo'),
            ),
          ).called(1);
        },
      );
    });
  });
}
