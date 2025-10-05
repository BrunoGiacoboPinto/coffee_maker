import 'package:freezed_annotation/freezed_annotation.dart';

part 'coffee_photo_response.freezed.dart';
part 'coffee_photo_response.g.dart';

/// Response model for coffee photo data
@freezed
abstract class CoffeePhotoResponse with _$CoffeePhotoResponse {
  /// Creates a [CoffeePhotoResponse] instance
  const factory CoffeePhotoResponse({
    /// The file path or URL of the coffee photo
    required String file,
  }) = _CoffeePhotoResponse;

  /// Creates a [CoffeePhotoResponse] from JSON
  factory CoffeePhotoResponse.fromJson(Map<String, Object?> json) =>
      _$CoffeePhotoResponseFromJson(json);
}
