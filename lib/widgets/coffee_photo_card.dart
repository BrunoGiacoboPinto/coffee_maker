import 'package:coffee_maker/widgets/coffe_photo_view.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

final class CoffeePhotoCard extends StatelessWidget {
  const CoffeePhotoCard({
    required this.photo,
    required this.onToggleFavorite,
    this.onTap,
    super.key,
  });

  final CoffeePhotoData photo;
  final ValueChanged<String> onToggleFavorite;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap?.call(photo.id) : null,
      child: CoffePhotoView(
        photo: photo,
        onToggleFavorite: onToggleFavorite,
        placeholder: const CoffeePhotoCardLoading(),
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
