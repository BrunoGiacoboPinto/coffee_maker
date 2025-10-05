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

  Future<void> toggleFavorite(String id) async {
    if (_cache[id] case final photo?) {
      _cache[id] = photo.copyWith(isFavorite: !photo.isFavorite);
      await _photosBox.put(id, _cache[id]!);
    }
  }

  Future<CoffeePhotoData?> getPhoto(String id) async {
    if (_cache[id] case final photo?) {
      return photo;
    } else if (_photosBox.containsKey(id)) {
      _cache[id] = _photosBox.get(id)!;
      return _cache[id];
    }

    return null;
  }

  Future<List<CoffeePhotoData>> getFavoritePhotos() async {
    return [..._cache.values.where((photo) => photo.isFavorite)];
  }

  List<CoffeePhotoData> getCachedPhotos() {
    return _cache.values.toList(growable: false);
  }

  String _extractPhotoId(CoffeePhotoResponse photo) {
    final url = Uri.parse(photo.file);
    return url.pathSegments.last.replaceAll('.jpg', '');
  }
}
