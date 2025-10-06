import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_maker/favorites/bloc/favorites_bloc.dart';
import 'package:coffee_maker/favorites/bloc/favorites_event.dart';
import 'package:coffee_maker/favorites/bloc/favorites_state.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCoffeePhotosRepository extends Mock
    implements CoffeePhotosRepository {}

void main() {
  group('FavoritesBloc', () {
    late FavoritesBloc favoritesBloc;
    late _MockCoffeePhotosRepository mockRepository;

    setUpAll(() {
      registerFallbackValue(
        const CoffeePhotoData(
          url: 'https://example.com/photo.jpg',
          id: 'test-id',
          isFavorite: true,
        ),
      );
    });

    setUp(() {
      mockRepository = _MockCoffeePhotosRepository();
      when(() => mockRepository.photosStream).thenAnswer(
        (_) => const Stream<List<CoffeePhotoData>>.empty(),
      );
    });

    tearDown(() async {
      await favoritesBloc.close();
    });

    group('initial state', () {
      test('should be initial when no cached favorites', () {
        when(() => mockRepository.hasCachedFavorites()).thenReturn(false);

        favoritesBloc = FavoritesBloc(coffeePhotosRepository: mockRepository);

        expect(favoritesBloc.state, const FavoritesState.initial());
      });

      test('should be success with cached favorites when favorites exist', () {
        final cachedFavorites = [
          const CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: true,
          ),
          const CoffeePhotoData(
            url: 'https://example.com/photo2.jpg',
            id: 'photo2',
            isFavorite: true,
          ),
        ];
        when(() => mockRepository.hasCachedFavorites()).thenReturn(true);
        when(
          () => mockRepository.getCachedFavorites(),
        ).thenReturn(cachedFavorites);

        favoritesBloc = FavoritesBloc(coffeePhotosRepository: mockRepository);

        expect(favoritesBloc.state, FavoritesState.success(cachedFavorites));
      });
    });

    group('FetchFavoritesEvent', () {
      setUp(() {
        when(() => mockRepository.hasCachedFavorites()).thenReturn(false);
        favoritesBloc = FavoritesBloc(coffeePhotosRepository: mockRepository);
      });

      blocTest<FavoritesBloc, FavoritesState>(
        'should emit loading then success when favorites are fetched '
        'successfully',
        build: () {
          final favorites = [
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: true,
            ),
            const CoffeePhotoData(
              url: 'https://example.com/photo2.jpg',
              id: 'photo2',
              isFavorite: true,
            ),
          ];
          when(
            () => mockRepository.getFavoritePhotos(),
          ).thenAnswer((_) async => favorites);
          return favoritesBloc;
        },
        act: (bloc) => bloc.add(const FavoritesEvent.fetchFavorites()),
        expect: () => [
          const FavoritesState.loading(),
          const FavoritesState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: true,
            ),
            CoffeePhotoData(
              url: 'https://example.com/photo2.jpg',
              id: 'photo2',
              isFavorite: true,
            ),
          ]),
        ],
        verify: (_) {
          verify(() => mockRepository.getFavoritePhotos()).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'should emit loading then error when fetch fails from initial state',
        build: () {
          when(
            () => mockRepository.getFavoritePhotos(),
          ).thenThrow(Exception('Network error'));
          return favoritesBloc;
        },
        act: (bloc) => bloc.add(const FavoritesEvent.fetchFavorites()),
        expect: () => [
          const FavoritesState.loading(),
          const FavoritesState.error('Exception: Network error'),
        ],
        verify: (_) {
          verify(() => mockRepository.getFavoritePhotos()).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'should not emit loading when already in success state',
        build: () {
          final cachedFavorites = [
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: true,
            ),
          ];
          when(() => mockRepository.hasCachedFavorites()).thenReturn(true);
          when(
            () => mockRepository.getCachedFavorites(),
          ).thenReturn(cachedFavorites);
          when(
            () => mockRepository.getFavoritePhotos(),
          ).thenThrow(Exception('Network error'));

          // ignore: discarded_futures - Close is called in test setup, future is intentionally discarded
          favoritesBloc.close();
          return favoritesBloc = FavoritesBloc(
            coffeePhotosRepository: mockRepository,
          );
        },
        act: (bloc) => bloc.add(const FavoritesEvent.fetchFavorites()),
        expect: () => <FavoritesState>[],
        verify: (_) {
          verify(() => mockRepository.getFavoritePhotos()).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'should maintain success state when fetch fails from success state',
        build: () {
          final cachedFavorites = [
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: true,
            ),
          ];
          when(() => mockRepository.hasCachedFavorites()).thenReturn(true);
          when(
            () => mockRepository.getCachedFavorites(),
          ).thenReturn(cachedFavorites);
          when(
            () => mockRepository.getFavoritePhotos(),
          ).thenThrow(Exception('Network error'));

          // ignore: discarded_futures - Close is called in test setup, future is intentionally discarded
          favoritesBloc.close();
          return favoritesBloc = FavoritesBloc(
            coffeePhotosRepository: mockRepository,
          );
        },
        act: (bloc) => bloc.add(const FavoritesEvent.fetchFavorites()),
        expect: () => <FavoritesState>[],
        verify: (_) {
          verify(() => mockRepository.getFavoritePhotos()).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'should handle empty favorites list',
        build: () {
          when(
            () => mockRepository.getFavoritePhotos(),
          ).thenAnswer((_) async => []);
          return favoritesBloc;
        },
        act: (bloc) => bloc.add(const FavoritesEvent.fetchFavorites()),
        expect: () => [
          const FavoritesState.loading(),
          const FavoritesState.success([]),
        ],
        verify: (_) {
          verify(() => mockRepository.getFavoritePhotos()).called(1);
        },
      );
    });

    group('ToggleFavoriteEvent', () {
      setUp(() {
        when(() => mockRepository.hasCachedFavorites()).thenReturn(false);
        favoritesBloc = FavoritesBloc(coffeePhotosRepository: mockRepository);
      });

      blocTest<FavoritesBloc, FavoritesState>(
        'should update favorites and emit success with updated list',
        build: () {
          final updatedFavorites = [
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ];
          when(
            () => mockRepository.toggleFavorite('photo1'),
          ).thenAnswer((_) async => null);
          when(
            () => mockRepository.getCachedFavorites(),
          ).thenReturn(updatedFavorites);
          return favoritesBloc;
        },
        act: (bloc) => bloc.add(const FavoritesEvent.toggleFavorite('photo1')),
        expect: () => <FavoritesState>[
          const FavoritesState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ]),
        ],
        verify: (_) {
          verify(() => mockRepository.toggleFavorite('photo1')).called(1);
          verify(() => mockRepository.getCachedFavorites()).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'should handle removing last favorite',
        build: () {
          when(
            () => mockRepository.toggleFavorite('photo1'),
          ).thenAnswer((_) async => null);
          when(() => mockRepository.getCachedFavorites()).thenReturn([]);
          return favoritesBloc;
        },
        act: (bloc) => bloc.add(const FavoritesEvent.toggleFavorite('photo1')),
        expect: () => [
          const FavoritesState.success([]),
        ],
        verify: (_) {
          verify(() => mockRepository.toggleFavorite('photo1')).called(1);
          verify(() => mockRepository.getCachedFavorites()).called(1);
        },
      );
    });

    group('PhotosUpdatedEvent', () {
      setUp(() {
        when(() => mockRepository.hasCachedFavorites()).thenReturn(false);
        favoritesBloc = FavoritesBloc(coffeePhotosRepository: mockRepository);
      });

      blocTest<FavoritesBloc, FavoritesState>(
        'should update favorites when photos are updated and in success state',
        build: () {
          when(
            () => mockRepository.getFavoritePhotos(),
          ).thenAnswer(
            (_) async => [
              const CoffeePhotoData(
                url: 'https://example.com/photo1.jpg',
                id: 'photo1',
                isFavorite: true,
              ),
            ],
          );
          return favoritesBloc;
        },
        act: (bloc) {
          bloc
            ..add(const FavoritesEvent.fetchFavorites())
            ..add(
              const FavoritesEvent.photosUpdated([
                CoffeePhotoData(
                  url: 'https://example.com/photo1.jpg',
                  id: 'photo1',
                  isFavorite: true,
                ),
                CoffeePhotoData(
                  url: 'https://example.com/photo2.jpg',
                  id: 'photo2',
                  isFavorite: false,
                ),
              ]),
            );
        },
        expect: () => [
          const FavoritesState.loading(),
          const FavoritesState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: true,
            ),
          ]),
        ],
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'should not update state when not in success state',
        build: () {
          return favoritesBloc;
        },
        act: (bloc) {
          bloc.add(
            const FavoritesEvent.photosUpdated([
              CoffeePhotoData(
                url: 'https://example.com/photo1.jpg',
                id: 'photo1',
                isFavorite: true,
              ),
            ]),
          );
        },
        expect: () => <FavoritesState>[],
      );
    });

    group('photosStream subscription', () {
      test(
        'should listen to photosStream and add PhotosUpdatedEvent',
        () async {
          final photosController = StreamController<List<CoffeePhotoData>>();
          when(() => mockRepository.photosStream).thenAnswer(
            (_) => photosController.stream,
          );
          when(() => mockRepository.hasCachedFavorites()).thenReturn(false);

          favoritesBloc = FavoritesBloc(coffeePhotosRepository: mockRepository);

          photosController.add([
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: true,
            ),
          ]);

          await pumpEventQueue();

          expect(favoritesBloc.state, const FavoritesState.initial());

          await photosController.close();
        },
      );
    });

    group('error handling', () {
      setUp(() {
        when(() => mockRepository.hasCachedFavorites()).thenReturn(false);
        favoritesBloc = FavoritesBloc(coffeePhotosRepository: mockRepository);
      });

      blocTest<FavoritesBloc, FavoritesState>(
        'should handle different types of exceptions',
        build: () {
          when(
            () => mockRepository.getFavoritePhotos(),
          ).thenThrow(ArgumentError('Invalid argument'));
          return favoritesBloc;
        },
        act: (bloc) => bloc.add(const FavoritesEvent.fetchFavorites()),
        expect: () => [
          const FavoritesState.loading(),
          const FavoritesState.error('Invalid argument(s): Invalid argument'),
        ],
        verify: (_) {
          verify(() => mockRepository.getFavoritePhotos()).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'should handle null error messages',
        build: () {
          when(() => mockRepository.getFavoritePhotos()).thenThrow(Exception());
          return favoritesBloc;
        },
        act: (bloc) => bloc.add(const FavoritesEvent.fetchFavorites()),
        expect: () => [
          const FavoritesState.loading(),
          const FavoritesState.error('Exception'),
        ],
        verify: (_) {
          verify(() => mockRepository.getFavoritePhotos()).called(1);
        },
      );
    });
  });
}
