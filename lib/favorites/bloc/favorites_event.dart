import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_event.freezed.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.fetchFavorites() = FetchFavoritesEvent;
  const factory FavoritesEvent.toggleFavorite(String id) = ToggleFavoriteEvent;
  const factory FavoritesEvent.photosUpdated(List<CoffeePhotoData> photos) =
      PhotosUpdatedEvent;
}
