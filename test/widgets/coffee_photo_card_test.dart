import 'package:coffee_maker/widgets/coffee_photo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
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
            ),
          );

          expect(find.byType(CoffeePhotoCard), findsOneWidget);
          expect(
            find.byType(GestureDetector),
            findsNWidgets(2),
          ); // One from CoffeePhotoCard, one from IconButton
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
            ),
          );

          expect(find.byType(IconButton), findsOneWidget);
          expect(find.byIcon(Icons.favorite_border), findsOneWidget);
        },
      );
    });

    group('interactions', () {
      testWidgets(
        'calls onTap callback when tapped',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
          );
          var onTapCalled = false;
          String? tappedPhotoId;

          await tester.pumpApp(
            CoffeePhotoCard(
              photo: photo,
              onToggleFavorite: (_) {},
              onTap: (id) {
                onTapCalled = true;
                tappedPhotoId = id;
              },
            ),
          );

          await tester.tap(find.byType(CoffeePhotoCard));
          await tester.pump();

          expect(onTapCalled, isTrue);
          expect(tappedPhotoId, equals('test-photo'));
        },
      );

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
            ),
          );

          await tester.tap(find.byType(IconButton));
          await tester.pump();

          expect(onToggleFavoriteCalled, isTrue);
          expect(toggledPhotoId, equals('test-photo'));
        },
      );

      testWidgets(
        'does not call onTap when onTap is null',
        (tester) async {
          final photo = TestDataFactory.createMockCoffeePhotoData(
            id: 'test-photo',
          );

          await tester.pumpApp(
            CoffeePhotoCard(
              photo: photo,
              onToggleFavorite: (_) {},
            ),
          );

          await tester.tap(find.byType(CoffeePhotoCard));
          await tester.pump();

          // Should not throw any exceptions
          expect(find.byType(CoffeePhotoCard), findsOneWidget);
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
