import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_event.freezed.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.fetchFavorites() = FetchFavoritesEvent;
  const factory FavoritesEvent.toggleFavorite(String id) = ToggleFavoriteEvent;
}
