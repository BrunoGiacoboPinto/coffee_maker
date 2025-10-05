import 'package:bloc/bloc.dart';
import 'package:coffee_maker/favorites/bloc/favorites_event.dart';
import 'package:coffee_maker/favorites/bloc/favorites_state.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:logging/logging.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required CoffeePhotosRepository coffeePhotosRepository,
  }) : _coffeePhotosRepository = coffeePhotosRepository,
       super(const FavoritesState.initial()) {
    on<FetchFavoritesEvent>(_onFetchFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);

    // Initialize with cached favorites if available
    final cachedFavorites = _coffeePhotosRepository
        .getCachedPhotos()
        .where((photo) => photo.isFavorite)
        .toList();
    if (cachedFavorites.isNotEmpty) {
      emit(FavoritesState.success(cachedFavorites));
    }
  }

  late final _logger = Logger('FavoritesBloc');
  final CoffeePhotosRepository _coffeePhotosRepository;

  Future<void> _onFetchFavorites(
    FetchFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is! FavoritesSuccessState) {
      emit(const FavoritesState.loading());
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
    final favorites = await _coffeePhotosRepository.getFavoritePhotos();
    emit(FavoritesState.success(favorites));
  }
}
