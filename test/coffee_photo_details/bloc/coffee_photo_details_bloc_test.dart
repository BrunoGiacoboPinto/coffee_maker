import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_bloc.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_event.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_state.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCoffeePhotosRepository extends Mock
    implements CoffeePhotosRepository {}

void main() {
  group('CoffeePhotoDetailsBloc', () {
    late CoffeePhotoDetailsBloc coffeePhotoDetailsBloc;
    late _MockCoffeePhotosRepository mockRepository;

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
      mockRepository = _MockCoffeePhotosRepository();
      coffeePhotoDetailsBloc = CoffeePhotoDetailsBloc(
        coffeePhotosRepository: mockRepository,
      );
    });

    tearDown(() async {
      await coffeePhotoDetailsBloc.close();
    });

    group('initial state', () {
      test('should be initial', () {
        expect(
          coffeePhotoDetailsBloc.state,
          const CoffeePhotoDetailsState.initial(),
        );
      });
    });

    group('FetchPhotoEvent', () {
      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should emit loading then success when photo is found',
        build: () {
          const photo = CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          );
          when(
            () => mockRepository.getPhoto('photo1'),
          ).thenAnswer((_) async => photo);
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.fetchPhoto('photo1')),
        expect: () => [
          const CoffeePhotoDetailsState.loading(),
          const CoffeePhotoDetailsState.success(
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.getPhoto('photo1')).called(1);
        },
      );

      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should emit loading then error when photo is not found',
        build: () {
          when(
            () => mockRepository.getPhoto('photo1'),
          ).thenAnswer((_) async => null);
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.fetchPhoto('photo1')),
        expect: () => [
          const CoffeePhotoDetailsState.loading(),
          const CoffeePhotoDetailsState.error('Photo not found'),
        ],
        verify: (_) {
          verify(() => mockRepository.getPhoto('photo1')).called(1);
        },
      );

      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should emit loading then error when repository throws exception',
        build: () {
          when(
            () => mockRepository.getPhoto('photo1'),
          ).thenThrow(Exception('Network error'));
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.fetchPhoto('photo1')),
        expect: () => [
          const CoffeePhotoDetailsState.loading(),
          const CoffeePhotoDetailsState.error('Exception: Network error'),
        ],
        verify: (_) {
          verify(() => mockRepository.getPhoto('photo1')).called(1);
        },
      );

      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should handle different types of exceptions',
        build: () {
          when(
            () => mockRepository.getPhoto('photo1'),
          ).thenThrow(ArgumentError('Invalid argument'));
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.fetchPhoto('photo1')),
        expect: () => [
          const CoffeePhotoDetailsState.loading(),
          const CoffeePhotoDetailsState.error(
            'Invalid argument(s): Invalid argument',
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.getPhoto('photo1')).called(1);
        },
      );

      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should handle null error messages',
        build: () {
          when(() => mockRepository.getPhoto('photo1')).thenThrow(Exception());
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.fetchPhoto('photo1')),
        expect: () => [
          const CoffeePhotoDetailsState.loading(),
          const CoffeePhotoDetailsState.error('Exception'),
        ],
        verify: (_) {
          verify(() => mockRepository.getPhoto('photo1')).called(1);
        },
      );

      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should handle empty photo id',
        build: () {
          when(() => mockRepository.getPhoto('')).thenAnswer((_) async => null);
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) => bloc.add(const CoffeePhotoDetailsEvent.fetchPhoto('')),
        expect: () => [
          const CoffeePhotoDetailsState.loading(),
          const CoffeePhotoDetailsState.error('Photo not found'),
        ],
        verify: (_) {
          verify(() => mockRepository.getPhoto('')).called(1);
        },
      );
    });

    group('ToggleFavoriteEvent', () {
      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should emit success with updated photo when toggle succeeds',
        build: () {
          const updatedPhoto = CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: true,
          );
          when(
            () => mockRepository.toggleFavorite('photo1'),
          ).thenAnswer((_) async => updatedPhoto);
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.toggleFavorite('photo1')),
        expect: () => [
          const CoffeePhotoDetailsState.success(
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: true,
            ),
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.toggleFavorite('photo1')).called(1);
        },
      );

      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should emit error when photo is not found during toggle',
        build: () {
          when(
            () => mockRepository.toggleFavorite('photo1'),
          ).thenAnswer((_) async => null);
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.toggleFavorite('photo1')),
        expect: () => [
          const CoffeePhotoDetailsState.error('Photo not found'),
        ],
        verify: (_) {
          verify(() => mockRepository.toggleFavorite('photo1')).called(1);
        },
      );

      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should emit error when toggle throws exception',
        build: () {
          when(
            () => mockRepository.toggleFavorite('photo1'),
          ).thenThrow(Exception('Toggle error'));
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.toggleFavorite('photo1')),
        expect: () => [
          const CoffeePhotoDetailsState.error('Exception: Toggle error'),
        ],
        verify: (_) {
          verify(() => mockRepository.toggleFavorite('photo1')).called(1);
        },
      );

      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should handle empty photo id in toggle',
        build: () {
          when(
            () => mockRepository.toggleFavorite(''),
          ).thenAnswer((_) async => null);
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.toggleFavorite('')),
        expect: () => [
          const CoffeePhotoDetailsState.error('Photo not found'),
        ],
        verify: (_) {
          verify(() => mockRepository.toggleFavorite('')).called(1);
        },
      );
    });

    group('state transitions', () {
      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should transition from initial to loading to success',
        build: () {
          const photo = CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          );
          when(
            () => mockRepository.getPhoto('photo1'),
          ).thenAnswer((_) async => photo);
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) =>
            bloc.add(const CoffeePhotoDetailsEvent.fetchPhoto('photo1')),
        expect: () => [
          const CoffeePhotoDetailsState.loading(),
          const CoffeePhotoDetailsState.success(
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ),
        ],
      );

      blocTest<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
        'should transition from success to loading to success on new fetch',
        build: () {
          const photo1 = CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          );
          const photo2 = CoffeePhotoData(
            url: 'https://example.com/photo2.jpg',
            id: 'photo2',
            isFavorite: true,
          );
          when(
            () => mockRepository.getPhoto('photo1'),
          ).thenAnswer((_) async => photo1);
          when(
            () => mockRepository.getPhoto('photo2'),
          ).thenAnswer((_) async => photo2);
          return coffeePhotoDetailsBloc;
        },
        act: (bloc) async {
          bloc.add(const CoffeePhotoDetailsEvent.fetchPhoto('photo1'));
          await Future<void>.delayed(const Duration(milliseconds: 100));
          bloc.add(const CoffeePhotoDetailsEvent.fetchPhoto('photo2'));
        },
        expect: () => [
          const CoffeePhotoDetailsState.loading(),
          const CoffeePhotoDetailsState.success(
            CoffeePhotoData(
              url: 'https://example.com/photo1.jpg',
              id: 'photo1',
              isFavorite: false,
            ),
          ),
          const CoffeePhotoDetailsState.loading(),
          const CoffeePhotoDetailsState.success(
            CoffeePhotoData(
              url: 'https://example.com/photo2.jpg',
              id: 'photo2',
              isFavorite: true,
            ),
          ),
        ],
      );
    });
  });
}
