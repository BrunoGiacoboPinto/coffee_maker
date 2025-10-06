import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_bloc.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_event.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_state.dart';
import 'package:coffee_maker/coffee_photo_details/view/coffee_photo_details.dart';
import 'package:coffee_maker/widgets/coffe_photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/helpers.dart';

class MockCoffeePhotoDetailsBloc extends Mock
    implements CoffeePhotoDetailsBloc {}

void main() {
  group('CoffeePhotoDetailsPage', () {
    late MockCoffeePhotoDetailsBloc mockBloc;

    setUp(() {
      mockBloc = MockCoffeePhotoDetailsBloc();
    });

    testWidgets(
      'renders CoffeePhotoDetailsPage',
      (tester) async {
        when(
          () => mockBloc.state,
        ).thenReturn(const CoffeePhotoDetailsState.loading());
        when(() => mockBloc.stream).thenAnswer(
          (_) => Stream.value(const CoffeePhotoDetailsState.loading()),
        );

        await tester.pumpApp(
          CoffeePhotoDetailsPage(
            photoId: 'test-photo-id',
            bloc: mockBloc,
          ),
        );

        expect(find.byType(CoffeePhotoDetailView), findsOneWidget);
      },
    );
  });

  group('CoffeePhotoDetailView', () {
    late MockCoffeePhotoDetailsBloc mockBloc;

    setUp(() {
      mockBloc = MockCoffeePhotoDetailsBloc();
    });

    group('rendering', () {
      testWidgets(
        'renders CoffeePhotoDetailView for CoffeePhotoDetailsLoadingState',
        (tester) async {
          when(
            () => mockBloc.state,
          ).thenReturn(const CoffeePhotoDetailsState.loading());
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(const CoffeePhotoDetailsState.loading()),
          );

          await tester.pumpApp(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
          );

          expect(find.byType(Shimmer), findsOneWidget);
          expect(find.byType(CoffePhotoView), findsNothing);
        },
      );

      testWidgets(
        'renders CoffeePhotoDetailView for CoffeePhotoDetailsSuccessState',
        (tester) async {
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

          await tester.pumpApp(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
          );

          expect(find.byType(CoffePhotoView), findsOneWidget);
          expect(find.byType(Shimmer), findsNothing);
        },
      );

      testWidgets(
        'renders CoffeePhotoDetailView for CoffeePhotoDetailsErrorState',
        (tester) async {
          when(
            () => mockBloc.state,
          ).thenReturn(const CoffeePhotoDetailsState.error('Test error'));
          when(() => mockBloc.stream).thenAnswer(
            (_) =>
                Stream.value(const CoffeePhotoDetailsState.error('Test error')),
          );

          await tester.pumpApp(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
          );

          expect(find.byType(Shimmer), findsOneWidget);
          expect(find.byType(CoffePhotoView), findsNothing);
        },
      );

      testWidgets(
        'renders CoffeePhotoDetailView for CoffeePhotoDetailsInitialState',
        (tester) async {
          when(
            () => mockBloc.state,
          ).thenReturn(const CoffeePhotoDetailsState.initial());
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(const CoffeePhotoDetailsState.initial()),
          );

          await tester.pumpApp(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
          );

          expect(find.byType(Shimmer), findsOneWidget);
          expect(find.byType(CoffePhotoView), findsNothing);
        },
      );
    });

    group('interactions', () {
      testWidgets(
        'adds ToggleFavoriteEvent when favorite icon is tapped',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo-id',
            isFavorite: true,
          );
          when(
            () => mockBloc.state,
          ).thenReturn(CoffeePhotoDetailsState.success(photo));
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(CoffeePhotoDetailsState.success(photo)),
          );

          await tester.pumpAppWithRouter(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
          );

          final favoriteIcon = find.byIcon(Icons.favorite);
          await tester.tap(favoriteIcon);
          await tester.pump();

          verify(
            () => mockBloc.add(
              const CoffeePhotoDetailsEvent.toggleFavorite('test-photo-id'),
            ),
          ).called(1);
        },
      );
    });

    group('initialization', () {
      testWidgets(
        'adds FetchPhotoEvent on initialization',
        (tester) async {
          when(
            () => mockBloc.state,
          ).thenReturn(const CoffeePhotoDetailsState.loading());
          when(() => mockBloc.stream).thenAnswer(
            (_) => Stream.value(const CoffeePhotoDetailsState.loading()),
          );

          await tester.pumpApp(
            CoffeePhotoDetailView(bloc: mockBloc, photoId: 'test-photo-id'),
          );

          verify(
            () => mockBloc.add(
              const CoffeePhotoDetailsEvent.fetchPhoto('test-photo-id'),
            ),
          ).called(1);
        },
      );
    });
  });
}
