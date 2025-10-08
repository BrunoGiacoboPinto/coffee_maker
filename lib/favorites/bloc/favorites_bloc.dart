import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_maker/favorites/bloc/favorites_event.dart';
import 'package:coffee_maker/favorites/bloc/favorites_state.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:logging/logging.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required CoffeePhotosRepository coffeePhotosRepository,
  }) : _coffeePhotosRepository = coffeePhotosRepository,
       super(
         coffeePhotosRepository.hasCachedFavorites()
             ? FavoritesState.success(
                 coffeePhotosRepository.getCachedFavorites(),
               )
             : const FavoritesState.initial(),
       ) {
    on<FetchFavoritesEvent>(_onFetchFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<PhotosUpdatedEvent>(_onPhotosUpdated);

    _photosSubscription = _coffeePhotosRepository.photosStream.listen((photos) {
      add(
        FavoritesEvent.photosUpdated([...photos.where((p) => p.isFavorite)]),
      );
    });
  }

  late final _logger = Logger('FavoritesBloc');
  final CoffeePhotosRepository _coffeePhotosRepository;
  StreamSubscription<List<CoffeePhotoData>>? _photosSubscription;

  Future<void> _onFetchFavorites(
    FetchFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is FavoritesInitialState) {
      emit(const FavoritesState.loading());
    } else if (state is FavoritesSuccessState) {
      return;
    }

    try {
      final photos = await _coffeePhotosRepository.getFavoritePhotos();
      emit(FavoritesState.success(photos));
    } catch (error, stackTrace) {
      _logger.severe('Error fetching favorites: $error', error, stackTrace);
      if (state is! FavoritesSuccessState) {
        emit(FavoritesState.error(error.toString()));
      }
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    await _coffeePhotosRepository.toggleFavorite(event.id);
    final favorites = _coffeePhotosRepository.getCachedFavorites();
    emit(FavoritesState.success(favorites));
  }

  Future<void> _onPhotosUpdated(
    PhotosUpdatedEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is FavoritesSuccessState) {
      emit(FavoritesState.success(event.photos));
    }
  }

  @override
  Future<void> close() async {
    await _photosSubscription?.cancel();
    _photosSubscription = null;
    await super.close();
  }
}
