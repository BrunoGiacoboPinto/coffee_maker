import 'package:coffee_photos_repository/coffee_photos_repository.dart';

/// Factory methods for creating test data objects.
class TestDataFactory {
  /// Creates a mock [CoffeePhotoData] with customizable parameters.
  static CoffeePhotoData createMockCoffeePhotoData({
    String? id,
    String? url,
    bool? isFavorite,
  }) {
    return CoffeePhotoData(
      id: id ?? 'test-photo-${DateTime.now().millisecondsSinceEpoch}',
      url: url ?? 'https://example.com/test-photo.jpg',
      isFavorite: isFavorite ?? false,
    );
  }

  /// Creates a list of mock [CoffeePhotoData] for testing.
  static List<CoffeePhotoData> createMockCoffeePhotoList({
    int count = 3,
    bool allFavorites = false,
  }) {
    return List.generate(
      count,
      (index) => createMockCoffeePhotoData(
        id: 'test-photo-$index',
        url: 'https://example.com/test-photo-$index.jpg',
        isFavorite: allFavorites,
      ),
    );
  }

  /// Creates an empty list for testing empty states.
  static List<CoffeePhotoData> createEmptyCoffeePhotoList() {
    return <CoffeePhotoData>[];
  }

  /// Creates a single photo for testing single item scenarios.
  static List<CoffeePhotoData> createSingleCoffeePhotoList({
    bool isFavorite = false,
  }) {
    return [
      createMockCoffeePhotoData(
        id: 'single-photo',
        url: 'https://example.com/single-photo.jpg',
        isFavorite: isFavorite,
      ),
    ];
  }
}
