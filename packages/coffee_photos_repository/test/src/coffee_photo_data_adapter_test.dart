import 'package:coffee_photos_repository/src/models/coffee_photo_data.dart';
import 'package:coffee_photos_repository/src/models/coffee_photo_data_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';

void main() {
  group('CoffeePhotoDataAdapter', () {
    late Box<CoffeePhotoData> box;

    setUpAll(() async {
      Hive
        ..init('test')
        ..registerAdapter(CoffeePhotoDataAdapter());
      box = await Hive.openBox<CoffeePhotoData>('test_box');
    });

    tearDownAll(() async {
      await box.close();
      await Hive.deleteFromDisk();
    });

    test(
      'should serialize and deserialize CoffeePhotoData correctly',
      () async {
        const testData = CoffeePhotoData(
          url: 'https://example.com/photo.jpg',
          id: 'test-id',
          isFavorite: true,
        );

        await box.put('test-key', testData);
        final retrievedData = box.get('test-key');

        expect(retrievedData, equals(testData));
        expect(retrievedData?.url, equals('https://example.com/photo.jpg'));
        expect(retrievedData?.id, equals('test-id'));
        expect(retrievedData?.isFavorite, equals(true));
      },
    );
  });
}
