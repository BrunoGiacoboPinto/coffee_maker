import 'dart:async';

import 'package:coffee_photos_repository/src/coffee_photos_service.dart';
import 'package:coffee_photos_repository/src/models/coffee_photo_data.dart';
import 'package:coffee_photos_repository/src/models/coffee_photo_response.dart';
import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';
import 'package:logging/logging.dart';

/// {@template coffee_photos_repository}
/// The data layer to load beautiful coffee photos
/// {@endtemplate}
class CoffeePhotosRepository {
  /// {@macro coffee_photos_repository}
  CoffeePhotosRepository({
    required CoffeePhotosService coffeePhotosService,
    required Box<CoffeePhotoData> photosBox,
  }) : _coffeePhotosService = coffeePhotosService,
       _photosBox = photosBox;

  final CoffeePhotosService _coffeePhotosService;
  final Box<CoffeePhotoData> _photosBox;
  late final _cache = <String, CoffeePhotoData>{
    for (final photo in _photosBox.values) photo.id: photo,
  };

  late final _logger = Logger('CoffeePhotosRepository');
  final _photosController = StreamController<List<CoffeePhotoData>>.broadcast();

  /// Stream that emits updated photo lists whenever favorites change
  Stream<List<CoffeePhotoData>> get photosStream => _photosController.stream;

  /// Fetches coffee photos from the service and caches them locally.
  ///
  /// Returns a list of [CoffeePhotoData] objects.
  /// [count] specifies how many photos to fetch (default: 30).
  Future<List<CoffeePhotoData>> getCoffeePhotos({int count = 30}) async {
    try {
      final photos = await Future.wait<CoffeePhotoResponse>([
        for (int i = 0; i < count; i++) _coffeePhotosService.getCoffeePhotos(),
      ]);

      for (final photo in photos) {
        final id = _extractPhotoId(photo);
        if (!_cache.containsKey(id)) {
          _cache[id] = CoffeePhotoData(
            url: photo.file,
            id: id,
            isFavorite: false,
          );
          await _photosBox.put(id, _cache[id]!);
        }
      }
    } on DioException catch (error, stackTrace) {
      _logger.severe('Error fetching photos: $error', error, stackTrace);
    }

    return _cache.values.toList(growable: false);
  }

  /// Toggles the favorite status of a photo with the given [id].
  ///
  /// If the photo exists in cache, its favorite status will be flipped.
  Future<CoffeePhotoData?> toggleFavorite(String id) async {
    if (_cache[id] case final photo?) {
      _cache[id] = photo.copyWith(isFavorite: !photo.isFavorite);
      await _photosBox.put(id, _cache[id]!);
      _photosController.add(getCachedPhotos()); // Notify subscribers
      return _cache[id];
    }

    return null;
  }

  /// Retrieves a specific photo by its [id].
  ///
  /// Returns the [CoffeePhotoData] if found, null otherwise.
  Future<CoffeePhotoData?> getPhoto(String id) async {
    if (_cache[id] case final photo?) {
      return photo;
    } else if (_photosBox.containsKey(id)) {
      _cache[id] = _photosBox.get(id)!;
      return _cache[id];
    }

    return null;
  }

  /// Returns a list of all photos marked as favorites.
  ///
  /// Returns an empty list if no favorites are found.
  Future<List<CoffeePhotoData>> getFavoritePhotos() async {
    return [..._cache.values.where((photo) => photo.isFavorite)];
  }

  /// Returns all photos currently cached in memory.
  ///
  /// Returns a list of all [CoffeePhotoData] objects in the cache.
  List<CoffeePhotoData> getCachedPhotos() {
    return _cache.values.toList(growable: false);
  }

  /// Returns all favorite photos currently cached in memory.
  ///
  /// Returns a list of all [CoffeePhotoData] objects marked as favorites.
  List<CoffeePhotoData> getCachedFavorites() {
    return _cache.values
        .where((photo) => photo.isFavorite)
        .toList(growable: false);
  }

  /// Checks whether there are any favorite photos cached in memory.
  ///
  /// Returns true if at least one cached photo is marked as favorite.
  bool hasCachedFavorites() {
    return _cache.values.any((photo) => photo.isFavorite);
  }

  String _extractPhotoId(CoffeePhotoResponse photo) {
    final url = Uri.parse(photo.file);
    return url.pathSegments.last.replaceAll('.jpg', '');
  }

  /// Disposes of the stream controller to prevent memory leaks
  Future<void> dispose() async {
    await _photosController.close();
  }
}
