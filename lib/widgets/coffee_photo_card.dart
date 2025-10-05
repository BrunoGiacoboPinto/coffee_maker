import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

final class CoffeePhotoCard extends StatelessWidget {
  const CoffeePhotoCard({
    required this.photo,
    super.key,
  });

  final CoffeePhotoData photo;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: photo.url,
      fit: BoxFit.cover,
      placeholder: (context, url) => const CoffeePhotoCardLoading(),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[300],
        child: const Icon(Icons.error, color: Colors.red),
      ),
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
