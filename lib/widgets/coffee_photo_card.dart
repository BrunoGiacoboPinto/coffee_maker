import 'package:animations/animations.dart';
import 'package:coffee_maker/coffee_photo_details/coffee_photo_details.dart';
import 'package:coffee_maker/widgets/coffe_photo_view.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

final class CoffeePhotoCard extends StatelessWidget {
  const CoffeePhotoCard({
    required this.photo,
    required this.onToggleFavorite,
    required this.detailsBloc,
    super.key,
  });

  final CoffeePhotoData photo;
  final ValueChanged<String> onToggleFavorite;
  final CoffeePhotoDetailsBloc detailsBloc;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return CoffeePhotoDetailsPage(
          photoId: photo.id,
          bloc: detailsBloc,
        );
      },
      closedBuilder: (context, openContainer) {
        return CoffePhotoView(
          photo: photo,
          onToggleFavorite: onToggleFavorite,
          placeholder: const CoffeePhotoCardLoading(),
        );
      },
      closedElevation: 0,
      openElevation: 0,
      closedShape: const RoundedRectangleBorder(),
      closedColor: Colors.transparent,
      openColor: Theme.of(context).colorScheme.surface,
    );
  }
}

final class CoffeePhotoCardLoading extends StatelessWidget {
  const CoffeePhotoCardLoading({super.key});

  static final Color _kNeutralColor = Colors.grey[300]!;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kNeutralColor,
      highlightColor: _kNeutralColor,
      child: Container(color: _kNeutralColor),
    );
  }
}
