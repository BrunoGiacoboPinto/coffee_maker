// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoffeePhotosRepository', () {
    test('can be instantiated', () {
      expect(CoffeePhotosRepository(), isNotNull);
    });
  });
}
