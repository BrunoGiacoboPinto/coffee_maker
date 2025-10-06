import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

class _MockCoffeePhotosService extends Mock implements CoffeePhotosService {}

class _MockPhotosBox extends Mock implements Box<CoffeePhotoData> {}

void main() {
  group('CoffeePhotosRepository', () {
    late CoffeePhotosRepository repository;
    late _MockCoffeePhotosService mockService;
    late _MockPhotosBox mockBox;

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
      mockService = _MockCoffeePhotosService();
      mockBox = _MockPhotosBox();

      when(() => mockBox.values).thenReturn([]);
      when(() => mockBox.containsKey(any<String>())).thenReturn(false);
      when(() => mockBox.get(any<String>())).thenReturn(null);

      repository = CoffeePhotosRepository(
        coffeePhotosService: mockService,
        photosBox: mockBox,
      );
    });

    group('instantiation', () {
      test('initializes cache from box values', () {
        final photos = [
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

        when(() => mockBox.values).thenReturn(photos);

        final newRepository = CoffeePhotosRepository(
          coffeePhotosService: mockService,
          photosBox: mockBox,
        );

        expect(newRepository.getCachedPhotos(), equals(photos));
      });
    });

    group('getCoffeePhotos', () {
      test('should fetch and cache new photos successfully', () async {
        final photoResponses = [
          const CoffeePhotoResponse(file: 'https://example.com/photo1.jpg'),
          const CoffeePhotoResponse(file: 'https://example.com/photo2.jpg'),
        ];
        when(
          () => mockService.getCoffeePhotos(),
        ).thenAnswer((_) async => photoResponses[0]);
        when(
          () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
        ).thenAnswer((_) async {});

        final result = await repository.getCoffeePhotos(count: 2);

        expect(result, hasLength(2));
        expect(result[0].id, 'photo1');
        expect(result[1].id, 'photo2');
        verify(() => mockService.getCoffeePhotos()).called(2);
        verify(
          () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
        ).called(2);
      });

      test('should handle DioException gracefully', () async {
        when(() => mockService.getCoffeePhotos()).thenThrow(
          DioException(requestOptions: RequestOptions(path: '/test')),
        );

        final result = await repository.getCoffeePhotos();

        expect(result, isEmpty);
        verify(() => mockService.getCoffeePhotos()).called(30);
      });

      test('should deduplicate photos based on ID', () async {
        const photoResponse = CoffeePhotoResponse(
          file: 'https://example.com/photo1.jpg',
        );

        when(
          () => mockService.getCoffeePhotos(),
        ).thenAnswer((_) async => photoResponse);

        when(
          () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
        ).thenAnswer((_) async {});

        await repository.getCoffeePhotos(count: 2);
        final result = await repository.getCoffeePhotos(count: 2);

        expect(result, hasLength(1));
        verify(
          () => mockService.getCoffeePhotos(),
        ).called(4);
        verify(
          () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
        ).called(1);
      });

      test('should handle empty photo responses', () async {
        when(() => mockService.getCoffeePhotos()).thenThrow(
          DioException(requestOptions: RequestOptions(path: '/test')),
        );

        final result = await repository.getCoffeePhotos(count: 0);

        expect(result, isEmpty);
        verifyNever(() => mockService.getCoffeePhotos());
      });

      test('should extract photo ID correctly from URL', () async {
        const photoResponse = CoffeePhotoResponse(
          file: 'https://example.com/path/to/photo123.jpg',
        );
        when(
          () => mockService.getCoffeePhotos(),
        ).thenAnswer((_) async => photoResponse);
        when(
          () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
        ).thenAnswer((_) async {});

        final result = await repository.getCoffeePhotos(count: 1);

        expect(result[0].id, 'photo123');
      });
    });

    group('toggleFavorite', () {
      test('should toggle favorite status for existing photo', () async {
        when(
          () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
        ).thenAnswer((_) async {});

        await repository.getCoffeePhotos(count: 1);
        when(() => mockService.getCoffeePhotos()).thenAnswer(
          (_) async =>
              const CoffeePhotoResponse(file: 'https://example.com/photo1.jpg'),
        );

        final result = await repository.toggleFavorite('photo1');

        expect(result, isNotNull);
        expect(result!.isFavorite, isTrue);
        verify(() => mockBox.put('photo1', any())).called(1);
      });

      test('should return null for non-existent photo', () async {
        final result = await repository.toggleFavorite('non-existent');

        expect(result, isNull);
        verifyNever(() => mockBox.put(any<String>(), any<CoffeePhotoData>()));
      });

      test('should handle toggle error gracefully', () async {
        when(
          () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
        ).thenThrow(Exception('Storage error'));

        when(() => mockService.getCoffeePhotos()).thenAnswer(
          (_) async =>
              const CoffeePhotoResponse(file: 'https://example.com/photo1.jpg'),
        );
        await repository.getCoffeePhotos(count: 1);

        expect(() => repository.toggleFavorite('photo1'), throwsException);
      });
    });

    group('getPhoto', () {
      test('should return photo from cache', () async {
        when(() => mockService.getCoffeePhotos()).thenAnswer(
          (_) async =>
              const CoffeePhotoResponse(file: 'https://example.com/photo1.jpg'),
        );
        when(
          () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
        ).thenAnswer((_) async {});
        await repository.getCoffeePhotos(count: 1);

        final result = await repository.getPhoto('photo1');

        expect(result, isNotNull);
        expect(result!.id, 'photo1');
      });

      test('should return photo from box when not in cache', () async {
        const photo = CoffeePhotoData(
          url: 'https://example.com/photo1.jpg',
          id: 'photo1',
          isFavorite: true,
        );
        when(() => mockBox.containsKey('photo1')).thenReturn(true);
        when(() => mockBox.get('photo1')).thenReturn(photo);

        final result = await repository.getPhoto('photo1');

        expect(result, equals(photo));
        verify(() => mockBox.containsKey('photo1')).called(1);
        verify(() => mockBox.get('photo1')).called(1);
      });

      test('should return null when photo not found', () async {
        final result = await repository.getPhoto('non-existent');

        expect(result, isNull);
        verify(() => mockBox.containsKey('non-existent')).called(1);
      });
    });

    group('getFavoritePhotos', () {
      test('should return only favorite photos', () async {
        final photos = [
          const CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: true,
          ),
          const CoffeePhotoData(
            url: 'https://example.com/photo2.jpg',
            id: 'photo2',
            isFavorite: false,
          ),
          const CoffeePhotoData(
            url: 'https://example.com/photo3.jpg',
            id: 'photo3',
            isFavorite: true,
          ),
        ];
        when(() => mockBox.values).thenReturn(photos);

        final newRepository = CoffeePhotosRepository(
          coffeePhotosService: mockService,
          photosBox: mockBox,
        );

        final result = await newRepository.getFavoritePhotos();

        expect(result, hasLength(2));
        expect(result.every((photo) => photo.isFavorite), isTrue);
      });

      test('should return empty list when no favorites', () async {
        final result = await repository.getFavoritePhotos();

        expect(result, isEmpty);
      });
    });

    group('getCachedPhotos', () {
      test('should return all cached photos', () {
        final photos = [
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
        when(() => mockBox.values).thenReturn(photos);

        final newRepository = CoffeePhotosRepository(
          coffeePhotosService: mockService,
          photosBox: mockBox,
        );

        final result = newRepository.getCachedPhotos();

        expect(result, equals(photos));
      });

      test('should return empty list when cache is empty', () {
        final result = repository.getCachedPhotos();

        expect(result, isEmpty);
      });
    });

    group('getCachedFavorites', () {
      test('should return only cached favorite photos', () {
        final photos = [
          const CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: true,
          ),
          const CoffeePhotoData(
            url: 'https://example.com/photo2.jpg',
            id: 'photo2',
            isFavorite: false,
          ),
        ];
        when(() => mockBox.values).thenReturn(photos);

        final newRepository = CoffeePhotosRepository(
          coffeePhotosService: mockService,
          photosBox: mockBox,
        );

        final result = newRepository.getCachedFavorites();

        expect(result, hasLength(1));
        expect(result[0].isFavorite, isTrue);
      });

      test('should return empty list when no cached favorites', () {
        final result = repository.getCachedFavorites();
        expect(result, isEmpty);
      });
    });

    group('hasCachedFavorites', () {
      test('should return true when favorites exist in cache', () {
        final photos = [
          const CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: true,
          ),
        ];
        when(() => mockBox.values).thenReturn(photos);

        final newRepository = CoffeePhotosRepository(
          coffeePhotosService: mockService,
          photosBox: mockBox,
        );

        final result = newRepository.hasCachedFavorites();

        expect(result, isTrue);
      });

      test('should return false when no favorites in cache', () {
        final result = repository.hasCachedFavorites();

        expect(result, isFalse);
      });

      test('should return false when cache has photos but no favorites', () {
        final photos = [
          const CoffeePhotoData(
            url: 'https://example.com/photo1.jpg',
            id: 'photo1',
            isFavorite: false,
          ),
        ];
        when(() => mockBox.values).thenReturn(photos);

        final newRepository = CoffeePhotosRepository(
          coffeePhotosService: mockService,
          photosBox: mockBox,
        );

        final result = newRepository.hasCachedFavorites();

        expect(result, isFalse);
      });
    });

    group('photo ID extraction', () {
      test('should extract ID from various URL formats', () async {
        final testCases = [
          ('https://example.com/photo123.jpg', 'photo123'),
          ('https://example.com/path/to/image456.jpg', 'image456'),
          ('https://example.com/deep/path/to/file789.jpg', 'file789'),
          ('https://example.com/photo.jpg', 'photo'),
        ];

        for (final (url, expectedId) in testCases) {
          when(
            () => mockService.getCoffeePhotos(),
          ).thenAnswer((_) async => CoffeePhotoResponse(file: url));
          when(
            () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
          ).thenAnswer((_) async {});

          final result = await repository.getCoffeePhotos(count: 1);

          expect(result[0].id, expectedId, reason: 'Failed for URL: $url');
        }
      });
    });

    group('error handling', () {
      test('should handle service errors gracefully', () async {
        when(() => mockService.getCoffeePhotos()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/test'),
            error: 'Network error',
          ),
        );

        final result = await repository.getCoffeePhotos();

        expect(result, isEmpty);
      });

      test('should handle box storage errors', () async {
        when(() => mockService.getCoffeePhotos()).thenAnswer(
          (_) async =>
              const CoffeePhotoResponse(file: 'https://example.com/photo1.jpg'),
        );
        when(
          () => mockBox.put(any<String>(), any<CoffeePhotoData>()),
        ).thenThrow(Exception('Storage error'));

        expect(() => repository.getCoffeePhotos(), throwsException);
      });
    });
  });
}
