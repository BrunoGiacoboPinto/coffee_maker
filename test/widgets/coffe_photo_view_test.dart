import 'package:coffee_maker/widgets/coffe_photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('CoffePhotoView', () {
    group('rendering', () {
      testWidgets(
        'renders CoffePhotoView with photo data',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
            url: 'https://example.com/test-photo.jpg',
            isFavorite: false,
          );

          await tester.pumpApp(
            CoffePhotoView(
              photo: photo,
              onToggleFavorite: (_) {},
            ),
          );

          expect(find.byType(CoffePhotoView), findsOneWidget);
          expect(find.byType(Stack), findsOneWidget);
          expect(find.byType(Positioned), findsWidgets);
        },
      );

      testWidgets(
        'renders CoffePhotoView with favorite icon when photo is favorite',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
            isFavorite: true,
          );

          await tester.pumpApp(
            CoffePhotoView(
              photo: photo,
              onToggleFavorite: (_) {},
            ),
          );

          expect(find.byType(IconButton), findsOneWidget);
          expect(find.byIcon(Icons.favorite), findsOneWidget);
        },
      );

      testWidgets(
        'renders CoffePhotoView with unfavorite icon when photo is not '
        'favorite',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
            isFavorite: false,
          );

          await tester.pumpApp(
            CoffePhotoView(
              photo: photo,
              onToggleFavorite: (_) {},
            ),
          );

          expect(find.byType(IconButton), findsOneWidget);
          expect(find.byIcon(Icons.favorite_border), findsOneWidget);
        },
      );

      testWidgets(
        'renders CoffePhotoView with back button when '
        'automaticallyImplyLeading is true',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
          );

          await tester.pumpApp(
            CoffePhotoView(
              photo: photo,
              onToggleFavorite: (_) {},
              automaticallyImplyLeading: true,
            ),
          );

          expect(
            find.byType(IconButton),
            findsNWidgets(2),
          ); // Back button + favorite button
          expect(find.byIcon(Icons.arrow_back), findsOneWidget);
        },
      );

      testWidgets(
        'renders CoffePhotoView without back button when '
        'automaticallyImplyLeading is false',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
          );

          await tester.pumpApp(
            CoffePhotoView(
              photo: photo,
              onToggleFavorite: (_) {},
            ),
          );

          expect(
            find.byType(IconButton),
            findsOneWidget,
          );
          expect(find.byIcon(Icons.arrow_back), findsNothing);
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
            CoffePhotoView(
              photo: photo,
              onToggleFavorite: (id) {
                onToggleFavoriteCalled = true;
                toggledPhotoId = id;
              },
            ),
          );

          final favoriteButton = find.byIcon(Icons.favorite_border);
          await tester.tap(favoriteButton);
          await tester.pump();

          expect(onToggleFavoriteCalled, isTrue);
          expect(toggledPhotoId, equals('test-photo'));
        },
      );
    });
  });
}
