import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_maker/home/bloc/home_event.dart';
import 'package:coffee_maker/home/bloc/home_state.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:logging/logging.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required CoffeePhotosRepository coffeePhotosRepository,
  }) : _coffeePhotosRepository = coffeePhotosRepository,
       super(
         coffeePhotosRepository.getCachedPhotos().isEmpty
             ? const HomeState.initial()
             : HomeState.success(coffeePhotosRepository.getCachedPhotos()),
       ) {
    on<FetchPhotosEvent>(_onFetchPhotos);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<PhotosUpdatedEvent>(_onPhotosUpdated);
    on<LoadMorePhotosEvent>(_onLoadMorePhotos);

    _photosSubscription = _coffeePhotosRepository.photosStream.listen((photos) {
      add(HomeEvent.photosUpdated(photos));
    });
  }

  late final _logger = Logger('HomeBloc');
  final CoffeePhotosRepository _coffeePhotosRepository;
  late final StreamSubscription<List<CoffeePhotoData>> _photosSubscription;
  int _currentBatch = 0;
  static const int _batchSize = 15;

  Future<void> _onFetchPhotos(
    FetchPhotosEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSuccessState) {
      emit(const HomeState.loading());
    }

    try {
      _currentBatch = 0;
      final photos = await _coffeePhotosRepository.getCoffeePhotos();
      emit(HomeState.success(photos));
    } catch (error, stackTrace) {
      _logger.severe('Error fetching photos: $error', error, stackTrace);
      if (state is! HomeSuccessState) {
        emit(HomeState.error(error.toString()));
      }
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _coffeePhotosRepository.toggleFavorite(event.id);
    emit(HomeState.success(_coffeePhotosRepository.getCachedPhotos()));
  }

  Future<void> _onPhotosUpdated(
    PhotosUpdatedEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeSuccessState) {
      emit(HomeState.success(event.photos));
    }
  }

  Future<void> _onLoadMorePhotos(
    LoadMorePhotosEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomeSuccessState ||
        currentState.isLoadingMore ||
        currentState.hasReachedMax) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      _currentBatch++;
      final newPhotos = await _coffeePhotosRepository.getCoffeePhotos(
        count: _batchSize,
      );

      final allPhotos = [...currentState.photos, ...newPhotos];
      final hasReachedMax = newPhotos.length < _batchSize;

      _logger.info(
        'Loaded batch $_currentBatch: ${newPhotos.length} photos, '
        'total: ${allPhotos.length}',
      );

      emit(
        HomeState.success(
          allPhotos,
          hasReachedMax: hasReachedMax,
        ),
      );
    } catch (error, stackTrace) {
      _logger.severe('Error loading more photos: $error', error, stackTrace);
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  @override
  Future<void> close() async {
    await _photosSubscription.cancel();
    return super.close();
  }
}
