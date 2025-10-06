import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_bloc.dart';
import 'package:coffee_maker/widgets/coffee_photo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

class MockCoffeePhotoDetailsBloc extends Mock
    implements CoffeePhotoDetailsBloc {}

void main() {
  late MockCoffeePhotoDetailsBloc mockDetailsBloc;

  setUp(() {
    mockDetailsBloc = MockCoffeePhotoDetailsBloc();
  });

  group('CoffeePhotoCard', () {
    group('rendering', () {
      testWidgets(
        'renders CoffeePhotoCard with photo data',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
            url: 'https://example.com/test-photo.jpg',
            isFavorite: false,
          );

          await tester.pumpApp(
            CoffeePhotoCard(
              photo: photo,
              onToggleFavorite: (_) {},
              detailsBloc: mockDetailsBloc,
            ),
          );

          expect(find.byType(CoffeePhotoCard), findsOneWidget);
        },
      );

      testWidgets(
        'renders CoffeePhotoCard with favorite icon',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
            isFavorite: true,
          );

          await tester.pumpApp(
            CoffeePhotoCard(
              photo: photo,
              onToggleFavorite: (_) {},
              detailsBloc: mockDetailsBloc,
            ),
          );

          expect(find.byType(IconButton), findsOneWidget);
          expect(find.byIcon(Icons.favorite), findsOneWidget);
        },
      );

      testWidgets(
        'renders CoffeePhotoCard with unfavorite icon',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
            isFavorite: false,
          );

          await tester.pumpApp(
            CoffeePhotoCard(
              photo: photo,
              onToggleFavorite: (_) {},
              detailsBloc: mockDetailsBloc,
            ),
          );

          expect(find.byType(IconButton), findsOneWidget);
          expect(find.byIcon(Icons.favorite_border), findsOneWidget);
        },
      );
    });

    group('interactions', () {
      testWidgets(
        'calls onToggleFavorite callback when favorite icon is tapped',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
          );
          var onToggleFavoriteCalled = false;
          String? toggledPhotoId;

          await tester.pumpApp(
            CoffeePhotoCard(
              photo: photo,
              onToggleFavorite: (id) {
                onToggleFavoriteCalled = true;
                toggledPhotoId = id;
              },
              detailsBloc: mockDetailsBloc,
            ),
          );

          await tester.tap(find.byType(IconButton));
          await tester.pump();

          expect(onToggleFavoriteCalled, isTrue);
          expect(toggledPhotoId, equals('test-photo'));
        },
      );
    });

    group('CoffeePhotoCardLoading', () {
      testWidgets(
        'renders CoffeePhotoCardLoading with shimmer effect',
        (tester) async {
          await tester.pumpApp(
            const CoffeePhotoCardLoading(),
          );

          expect(find.byType(CoffeePhotoCardLoading), findsOneWidget);
          expect(find.byType(Container), findsOneWidget);
        },
      );
    });
  });
}
