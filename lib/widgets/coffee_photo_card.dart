import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

final class CoffeePhotoCard extends StatelessWidget {
  const CoffeePhotoCard({
    required this.photo,
    required this.onToggleFavorite,
    super.key,
  });

  final CoffeePhotoData photo;
  final ValueChanged<String> onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: photo.url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CoffeePhotoCardLoading(),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.error, color: Colors.red),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              photo.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: photo.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => onToggleFavorite(photo.id),
          ),
        ),
      ],
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
