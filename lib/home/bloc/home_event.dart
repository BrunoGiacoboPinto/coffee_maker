import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.fetchPhotos() = FetchPhotosEvent;
  const factory HomeEvent.toggleFavorite(String id) = ToggleFavoriteEvent;
}
