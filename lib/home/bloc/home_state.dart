import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitialState;
  const factory HomeState.loading() = HomeLoadingState;
  const factory HomeState.success(List<CoffeePhotoData> photos) =
      HomeSuccessState;
  const factory HomeState.error(String message) = HomeErrorState;
}
