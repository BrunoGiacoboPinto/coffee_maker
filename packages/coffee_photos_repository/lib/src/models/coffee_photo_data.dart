import 'package:freezed_annotation/freezed_annotation.dart';

part 'coffee_photo_data.freezed.dart';
part 'coffee_photo_data.g.dart';

/// Response model for coffee photo data
@freezed
abstract class CoffeePhotoData with _$CoffeePhotoData {
  /// Creates a [CoffeePhotoData] instance
  const factory CoffeePhotoData({
    /// The URL of the coffee photo
    required String url,

    /// The ID of the coffee photo
    required String id,

    /// Whether the photo is a favorite
    required bool isFavorite,
  }) = _CoffeePhotoData;

  /// Creates a [CoffeePhotoData] from JSON
  factory CoffeePhotoData.fromJson(Map<String, Object?> json) =>
      _$CoffeePhotoDataFromJson(json);
}
