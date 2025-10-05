import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeePhotosService extends Mock implements CoffeePhotosService {}

class MockPhotosBox extends Mock implements Box<CoffeePhotoData> {}

void main() {
  group('CoffeePhotosRepository', () {
    late CoffeePhotosRepository repository;
    late MockCoffeePhotosService mockService;
    late MockPhotosBox mockBox;

    setUp(() {
      mockService = MockCoffeePhotosService();
      mockBox = MockPhotosBox();

      // Setup mock box to return empty values list
      when(() => mockBox.values).thenReturn([]);

      repository = CoffeePhotosRepository(
        coffeePhotosService: mockService,
        photosBox: mockBox,
      );
    });

    test('can be instantiated', () {
      expect(repository, isNotNull);
    });
  });
}
