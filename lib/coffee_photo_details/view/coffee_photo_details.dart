import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_bloc.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_event.dart';
import 'package:coffee_maker/coffee_photo_details/bloc/coffee_photo_details_state.dart';
import 'package:coffee_maker/widgets/coffe_photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CoffeePhotoDetailsPage extends StatelessWidget {
  const CoffeePhotoDetailsPage({
    required this.photoId,
    required this.bloc,
    super.key,
  });

  final String photoId;
  final CoffeePhotoDetailsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return CoffeePhotoDetailView(bloc: bloc, photoId: photoId);
  }
}

final class CoffeePhotoDetailView extends StatefulWidget {
  const CoffeePhotoDetailView({
    required this.bloc,
    required this.photoId,
    super.key,
  });

  final String photoId;
  final CoffeePhotoDetailsBloc bloc;

  @override
  State<CoffeePhotoDetailView> createState() => _CoffeePhotoDetailViewState();
}

class _CoffeePhotoDetailViewState extends State<CoffeePhotoDetailView> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(FetchPhotoEvent(widget.photoId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeePhotoDetailsBloc, CoffeePhotoDetailsState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: state.maybeWhen<Widget>(
            success: (photo) => CoffePhotoView(
              automaticallyImplyLeading: true,
              photo: photo,
              onToggleFavorite: (id) {
                widget.bloc.add(ToggleFavoriteEvent(id));
              },
            ),
            orElse: () => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const SizedBox.expand(),
            ),
          ),
        );
      },
    );
  }
}
