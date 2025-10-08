import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_bloc.dart';
import 'package:coffee_maker/di/injection.dart';
import 'package:coffee_maker/favorites/favorites.dart';
import 'package:coffee_maker/widgets/coffee_photo_card.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

final class FavoritesPage extends StatelessWidget {
  const FavoritesPage({
    required this.favoritesBloc,
    super.key,
  });

  final FavoritesBloc favoritesBloc;

  @override
  Widget build(BuildContext context) {
    return FavoritesView(favoritesBloc: favoritesBloc);
  }
}

final class FavoritesView extends StatefulWidget {
  @visibleForTesting
  const FavoritesView({
    required this.favoritesBloc,
    super.key,
  });

  final FavoritesBloc favoritesBloc;

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();
    widget.favoritesBloc.add(const FetchFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      bloc: widget.favoritesBloc,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: switch (state) {
            FavoritesLoadingState() ||
            FavoritesInitialState() => const _FavoritesViewLoading(),
            FavoritesSuccessState() =>
              state.photos.isEmpty
                  ? const _FavoritesViewEmpty()
                  : _FavoritesViewSuccess(
                      photos: state.photos,
                      onToggleFavorite: (id) {
                        widget.favoritesBloc.add(ToggleFavoriteEvent(id));
                      },
                    ),
            FavoritesErrorState() => const SizedBox.expand(),
            _ => const _FavoritesViewLoading(),
          },
        );
      },
    );
  }
}

final class _FavoritesViewLoading extends StatelessWidget {
  const _FavoritesViewLoading();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          height: 200,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

final class _FavoritesViewEmpty extends StatelessWidget {
  const _FavoritesViewEmpty();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Colors.grey,
          ),
          Gap(16),
          Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Gap(8),
          Text(
            'Tap the heart icon on photos to add them to your favorites',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

final class _FavoritesViewSuccess extends StatelessWidget {
  const _FavoritesViewSuccess({
    required this.photos,
    required this.onToggleFavorite,
  });

  final List<CoffeePhotoData> photos;
  final ValueChanged<String> onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SizedBox(
            height: 200,
            child: CoffeePhotoCard(
              photo: photos[index],
              onToggleFavorite: onToggleFavorite,
              detailsBloc: getIt<CoffeePhotoDetailsBloc>(),
            ),
          ),
        );
      },
    );
  }
}
