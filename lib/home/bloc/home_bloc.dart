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

    _photosSubscription = _coffeePhotosRepository.photosStream.listen((photos) {
      add(HomeEvent.photosUpdated(photos));
    });
  }

  late final _logger = Logger('HomeBloc');
  final CoffeePhotosRepository _coffeePhotosRepository;
  late final StreamSubscription<List<CoffeePhotoData>> _photosSubscription;

  Future<void> _onFetchPhotos(
    FetchPhotosEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSuccessState) {
      emit(const HomeState.loading());
    }

    try {
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

  @override
  Future<void> close() async {
    await _photosSubscription.cancel();
    return super.close();
  }
}
