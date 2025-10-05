import 'package:freezed_annotation/freezed_annotation.dart';

part 'coffee_photo_details_event.freezed.dart';

@freezed
class CoffeePhotoDetailsEvent with _$CoffeePhotoDetailsEvent {
  const factory CoffeePhotoDetailsEvent.fetchPhoto(String photoId) =
      FetchPhotoEvent;
  const factory CoffeePhotoDetailsEvent.toggleFavorite(String id) =
      ToggleFavoriteEvent;
}
