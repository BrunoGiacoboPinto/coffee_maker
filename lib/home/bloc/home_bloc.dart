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
  }

  late final _logger = Logger('HomeBloc');
  final CoffeePhotosRepository _coffeePhotosRepository;

  Future<void> _onFetchPhotos(
    FetchPhotosEvent event,
    Emitter<HomeState> emit,
  ) async {
    // Only show loading if we don't have photos yet
    if (state is! HomeSuccessState) {
      emit(const HomeState.loading());
    }

    try {
      final photos = await _coffeePhotosRepository.getCoffeePhotos();
      emit(HomeState.success(photos));
    } catch (error, stackTrace) {
      _logger.severe('Error fetching photos: $error', error, stackTrace);
      // Keep existing photos if available, otherwise show error
      if (state is! HomeSuccessState) {
        emit(HomeState.error(error.toString()));
      }
    }
  }
}
