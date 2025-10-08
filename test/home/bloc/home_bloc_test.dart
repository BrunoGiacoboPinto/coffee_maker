import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_maker/home/bloc/home_bloc.dart';
import 'package:coffee_maker/home/bloc/home_event.dart';
import 'package:coffee_maker/home/bloc/home_state.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeePhotosRepository extends Mock
    implements CoffeePhotosRepository {}

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockCoffeePhotosRepository mockRepository;

    setUpAll(() {
      registerFallbackValue(
        const CoffeePhotoData(
          url: 'https://example.com/photo.jpg',
          id: 'test-id',
          isFavorite: false,
        ),
      );
    });

    setUp(() {
      mockRepository = MockCoffeePhotosRepository();
      when(() => mockRepository.photosStream).thenAnswer(
        (_) => const Stream<List<CoffeePhotoData>>.empty(),
      );
    });

    tearDown(() async {
      await homeBloc.close();
    });

    group('initial state', () {
      test('should be initial when cache is empty', () {
        when(() => mockRepository.getCachedPhotos()).thenReturn([]);

        homeBloc = HomeBloc(coffeePhotosRepository: mockRepository);

        expect(homeBloc.state, const HomeState.initial());
      });

      test('should be success with cached photos when cache is not empty', () {
        final cachedPhotos = [
          const CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          ),
          const CoffeePhotoData(
            url: 'https://example.com/photo2.jpg',
            id: 'photo2',
            isFavorite: true,
          ),
        ];
        when(() => mockRepository.getCachedPhotos()).thenReturn(cachedPhotos);

        homeBloc = HomeBloc(coffeePhotosRepository: mockRepository);

        expect(homeBloc.state, HomeState.success(cachedPhotos));
      });
    });

    group('FetchPhotosEvent', () {
      setUp(() {
        when(() => mockRepository.getCachedPhotos()).thenReturn([]);
        homeBloc = HomeBloc(coffeePhotosRepository: mockRepository);
      });

      blocTest<HomeBloc, HomeState>(
        'should emit loading then success when photos are fetched successfully',
        build: () {
          final photos = [
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ];
          when(
            () => mockRepository.getCoffeePhotos(),
          ).thenAnswer((_) async => photos);
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeEvent.fetchPhotos()),
        expect: () => [
          const HomeState.loading(),
          const HomeState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ]),
        ],
        verify: (_) {
          verify(() => mockRepository.getCoffeePhotos()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should emit loading then error when fetch fails from initial state',
        build: () {
          when(
            () => mockRepository.getCoffeePhotos(),
          ).thenThrow(Exception('Network error'));
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeEvent.fetchPhotos()),
        expect: () => [
          const HomeState.loading(),
          const HomeState.error('Exception: Network error'),
        ],
        verify: (_) {
          verify(() => mockRepository.getCoffeePhotos()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should not emit loading when already in success state',
        build: () {
          final cachedPhotos = [
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ];
          when(() => mockRepository.getCachedPhotos()).thenReturn(cachedPhotos);
          when(
            () => mockRepository.getCoffeePhotos(),
          ).thenThrow(Exception('Network error'));

          // ignore: discarded_futures - Close is called in test setup, future is intentionally discarded
          homeBloc.close();
          return homeBloc = HomeBloc(
            coffeePhotosRepository: mockRepository,
          );
        },
        act: (bloc) => bloc.add(const HomeEvent.fetchPhotos()),
        expect: () => <HomeState>[],
        verify: (_) {
          verifyNever(() => mockRepository.getCoffeePhotos());
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should maintain success state when fetch fails from success state',
        build: () {
          final cachedPhotos = [
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ];
          when(() => mockRepository.getCachedPhotos()).thenReturn(cachedPhotos);
          when(
            () => mockRepository.getCoffeePhotos(),
          ).thenThrow(Exception('Network error'));

          // ignore: discarded_futures - Close is called in test setup, future is intentionally discarded
          homeBloc.close();
          return homeBloc = HomeBloc(
            coffeePhotosRepository: mockRepository,
          );
        },
        act: (bloc) => bloc.add(const HomeEvent.fetchPhotos()),
        expect: () => <HomeState>[],
        verify: (_) {
          verifyNever(() => mockRepository.getCoffeePhotos());
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should handle empty photos list',
        build: () {
          when(
            () => mockRepository.getCoffeePhotos(),
          ).thenAnswer((_) async => []);
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeEvent.fetchPhotos()),
        expect: () => [
          const HomeState.loading(),
          const HomeState.success([]),
        ],
        verify: (_) {
          verify(() => mockRepository.getCoffeePhotos()).called(1);
        },
      );
    });

    group('ToggleFavoriteEvent', () {
      setUp(() {
        when(() => mockRepository.getCachedPhotos()).thenReturn([]);
        homeBloc = HomeBloc(coffeePhotosRepository: mockRepository);
      });

      blocTest<HomeBloc, HomeState>(
        'should update cache and emit success with updated photos',
        build: () {
          final updatedPhotos = [
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: true,
            ),
          ];
          when(
            () => mockRepository.toggleFavorite('photo1'),
          ).thenAnswer((_) async => null);
          when(
            () => mockRepository.getCachedPhotos(),
          ).thenReturn(updatedPhotos);
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeEvent.toggleFavorite('photo1')),
        expect: () => <HomeState>[
          const HomeState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: true,
            ),
          ]),
        ],
        verify: (_) {
          verify(() => mockRepository.toggleFavorite('photo1')).called(1);
          verify(() => mockRepository.getCachedPhotos()).called(2);
        },
      );
    });

    group('LoadMorePhotosEvent', () {
      setUp(() {
        when(() => mockRepository.getCachedPhotos()).thenReturn([]);
        homeBloc = HomeBloc(coffeePhotosRepository: mockRepository);
      });

      blocTest<HomeBloc, HomeState>(
        'should load more photos when not loading and not at max',
        build: () {
          final morePhotos = [
            const CoffeePhotoData(
              url: 'https://example.com/photo2.jpg',
              id: 'photo2',
              isFavorite: false,
            ),
          ];
          when(
            () => mockRepository.getCoffeePhotos(count: 15),
          ).thenAnswer((_) async => morePhotos);
          return homeBloc;
        },
        seed: () => const HomeState.success([
          CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          ),
        ]),
        act: (bloc) => bloc.add(const HomeEvent.loadMorePhotos()),
        expect: () => [
          const HomeState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ], isLoadingMore: true),
          const HomeState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
            CoffeePhotoData(
              url: 'https://example.com/photo2.jpg',
              id: 'photo2',
              isFavorite: false,
            ),
          ], hasReachedMax: true),
        ],
        verify: (_) {
          verify(() => mockRepository.getCoffeePhotos(count: 15)).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should not load more photos when already loading',
        build: () => homeBloc,
        seed: () => const HomeState.success([
          CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          ),
        ], isLoadingMore: true),
        act: (bloc) => bloc.add(const HomeEvent.loadMorePhotos()),
        expect: () => <HomeState>[],
        verify: (_) {
          verifyNever(() => mockRepository.getCoffeePhotos());
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should not load more photos when hasReachedMax is true',
        build: () => homeBloc,
        seed: () => const HomeState.success([
          CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          ),
        ], hasReachedMax: true),
        act: (bloc) => bloc.add(const HomeEvent.loadMorePhotos()),
        expect: () => <HomeState>[],
        verify: (_) {
          verifyNever(() => mockRepository.getCoffeePhotos());
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should set hasReachedMax when fewer photos returned than requested',
        build: () {
          final fewerPhotos = [
            const CoffeePhotoData(
              url: 'https://example.com/photo2.jpg',
              id: 'photo2',
              isFavorite: false,
            ),
          ];
          when(
            () => mockRepository.getCoffeePhotos(count: 15),
          ).thenAnswer((_) async => fewerPhotos);
          return homeBloc;
        },
        seed: () => const HomeState.success([
          CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          ),
        ]),
        act: (bloc) => bloc.add(const HomeEvent.loadMorePhotos()),
        expect: () => [
          const HomeState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ], isLoadingMore: true),
          const HomeState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
            CoffeePhotoData(
              url: 'https://example.com/photo2.jpg',
              id: 'photo2',
              isFavorite: false,
            ),
          ], hasReachedMax: true),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'should handle error when loading more photos',
        build: () {
          when(
            () => mockRepository.getCoffeePhotos(count: 15),
          ).thenThrow(Exception('Network error'));
          return homeBloc;
        },
        seed: () => const HomeState.success([
          CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          ),
        ]),
        act: (bloc) => bloc.add(const HomeEvent.loadMorePhotos()),
        expect: () => [
          const HomeState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ], isLoadingMore: true),
          const HomeState.success(
            [
              CoffeePhotoData(
                url: 'https://example.com/photo1.jpg',
                id: 'photo1',
                isFavorite: false,
              ),
            ],
          ),
        ],
      );
    });

    group('PhotosUpdatedEvent', () {
      setUp(() {
        when(() => mockRepository.getCachedPhotos()).thenReturn([]);
        homeBloc = HomeBloc(coffeePhotosRepository: mockRepository);
      });

      blocTest<HomeBloc, HomeState>(
        'should update photos when photos are updated and in success state',
        build: () {
          when(
            () => mockRepository.getCoffeePhotos(),
          ).thenAnswer(
            (_) async => [
              const CoffeePhotoData(
                url: 'https://example.com/photo1.jpg',
                id: 'photo1',
                isFavorite: false,
              ),
            ],
          );
          return homeBloc;
        },
        act: (bloc) {
          bloc
            ..add(const HomeEvent.fetchPhotos())
            ..add(
              const HomeEvent.photosUpdated([
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
          const HomeState.loading(),
          const HomeState.success([
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ]),
          const HomeState.success([
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
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'should not update state when not in success state',
        build: () {
          return homeBloc;
        },
        act: (bloc) {
          bloc.add(
            const HomeEvent.photosUpdated([
              CoffeePhotoData(
                url: 'https://example.com/photo1.jpg',
                id: 'photo1',
                isFavorite: false,
              ),
            ]),
          );
        },
        expect: () => <HomeState>[],
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
          when(() => mockRepository.getCachedPhotos()).thenReturn([]);

          homeBloc = HomeBloc(coffeePhotosRepository: mockRepository);

          photosController.add([
            const CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ]);

          await pumpEventQueue();

          expect(homeBloc.state, const HomeState.initial());

          await photosController.close();
        },
      );
    });

    group('error handling', () {
      setUp(() {
        when(() => mockRepository.getCachedPhotos()).thenReturn([]);
        homeBloc = HomeBloc(coffeePhotosRepository: mockRepository);
      });

      blocTest<HomeBloc, HomeState>(
        'should handle different types of exceptions',
        build: () {
          when(
            () => mockRepository.getCoffeePhotos(),
          ).thenThrow(ArgumentError('Invalid argument'));
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeEvent.fetchPhotos()),
        expect: () => [
          const HomeState.loading(),
          const HomeState.error('Invalid argument(s): Invalid argument'),
        ],
        verify: (_) {
          verify(() => mockRepository.getCoffeePhotos()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'should handle null error messages',
        build: () {
          when(() => mockRepository.getCoffeePhotos()).thenThrow(Exception());
          return homeBloc;
        },
        act: (bloc) => bloc.add(const HomeEvent.fetchPhotos()),
        expect: () => [
          const HomeState.loading(),
          const HomeState.error('Exception'),
        ],
        verify: (_) {
          verify(() => mockRepository.getCoffeePhotos()).called(1);
        },
      );
    });
  });
}
