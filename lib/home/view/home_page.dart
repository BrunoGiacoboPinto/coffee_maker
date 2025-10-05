import 'package:coffee_maker/home/bloc/home_event.dart';
import 'package:coffee_maker/home/bloc/home_state.dart';
import 'package:coffee_maker/home/home.dart';
import 'package:coffee_maker/widgets/coffee_photo_card.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

final class HomePage extends StatelessWidget {
  const HomePage({required this.homeBloc, super.key});

  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) => HomeView(homeBloc: homeBloc);
}

final class HomeView extends StatefulWidget {
  @visibleForTesting
  const HomeView({required this.homeBloc, super.key});

  final HomeBloc homeBloc;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    widget.homeBloc.add(const FetchPhotosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: widget.homeBloc,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: switch (state) {
            HomeLoadingState() ||
            HomeInitialState() => const _HomeViewLoading(),
            HomeSuccessState() => _HomeViewSuccess(
              photos: state.photos,
              onToggleFavorite: (id) {
                widget.homeBloc.add(ToggleFavoriteEvent(id));
              },
            ),
            HomeErrorState() => const SizedBox.expand(),
            _ => const _HomeViewLoading(),
          },
        );
      },
    );
  }
}

final class _HomeViewLoading extends StatelessWidget {
  const _HomeViewLoading();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.custom(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: const [
            QuiltedGridTile(2, 2),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => Container(),
          childCount: 30,
        ),
      ),
    );
  }
}

final class _HomeViewSuccess extends StatelessWidget {
  const _HomeViewSuccess({
    required this.photos,
    required this.onToggleFavorite,
  });

  final List<CoffeePhotoData> photos;
  final ValueChanged<String> onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => CoffeePhotoCard(
          photo: photos[index],
          onToggleFavorite: onToggleFavorite,
        ),
        childCount: photos.length,
      ),
    );
  }
}
