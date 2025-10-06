import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coffee_photo_details_state.freezed.dart';

@freezed
class CoffeePhotoDetailsState with _$CoffeePhotoDetailsState {
  const factory CoffeePhotoDetailsState.initial() =
      CoffeePhotoDetailsInitialState;
  const factory CoffeePhotoDetailsState.loading() =
      CoffeePhotoDetailsLoadingState;
  const factory CoffeePhotoDetailsState.success(CoffeePhotoData photo) =
      CoffeePhotoDetailsSuccessState;
  const factory CoffeePhotoDetailsState.error(String message) =
      CoffeePhotoDetailsErrorState;
}
