import 'package:bloc/bloc.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_event.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_state.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:logging/logging.dart';

class CoffeePhotoDetailsBloc
    extends Bloc<CoffeePhotoDetailsEvent, CoffeePhotoDetailsState> {
  CoffeePhotoDetailsBloc({
    required CoffeePhotosRepository coffeePhotosRepository,
  }) : _coffeePhotosRepository = coffeePhotosRepository,
       super(const CoffeePhotoDetailsState.initial()) {
    on<FetchPhotoEvent>(_onFetchPhoto);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  final CoffeePhotosRepository _coffeePhotosRepository;
  late final _logger = Logger('CoffeePhotoDetailsBloc');

  Future<void> _onFetchPhoto(
    FetchPhotoEvent event,
    Emitter<CoffeePhotoDetailsState> emit,
  ) async {
    emit(const CoffeePhotoDetailsState.loading());

    try {
      final photo = await _coffeePhotosRepository.getPhoto(event.photoId);

      if (photo == null) {
        emit(const CoffeePhotoDetailsState.error('Photo not found'));
        return;
      } else {
        emit(CoffeePhotoDetailsState.success(photo));
      }
    } catch (error, stackTrace) {
      _logger.severe('Error fetching photo: $error', error, stackTrace);
      emit(CoffeePhotoDetailsState.error(error.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<CoffeePhotoDetailsState> emit,
  ) async {
    try {
      final photo = await _coffeePhotosRepository.toggleFavorite(event.id);
      if (photo == null) {
        emit(const CoffeePhotoDetailsState.error('Photo not found'));
        return;
      }

      emit(CoffeePhotoDetailsState.success(photo));
    } catch (error, stackTrace) {
      _logger.severe('Error toggling favorite: $error', error, stackTrace);
      emit(CoffeePhotoDetailsState.error(error.toString()));
    }
  }
}
