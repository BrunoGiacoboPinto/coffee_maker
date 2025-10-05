import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = FavoritesInitialState;
  const factory FavoritesState.loading() = FavoritesLoadingState;
  const factory FavoritesState.success(List<CoffeePhotoData> photos) =
      FavoritesSuccessState;
  const factory FavoritesState.error(String message) = FavoritesErrorState;
}
