import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_maker/l10n/l10n.dart';
import 'package:coffee_photos_repository/coffee_photos_repository.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CoffePhotoView extends StatelessWidget {
  const CoffePhotoView({
    required this.photo,
    required this.onToggleFavorite,
    this.placeholder,
    this.automaticallyImplyLeading = false,
    super.key,
  });

  final CoffeePhotoData photo;
  final ValueChanged<String> onToggleFavorite;
  final Widget? placeholder;
  final bool automaticallyImplyLeading;

  static const _kDarkCoffeeColor = Color(0xFF4A2C2A);

  @override
  Widget build(BuildContext context) {
    final top = automaticallyImplyLeading ? 8.0 : 0.0;

    final child = Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: photo.url,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 300),
          fadeOutDuration: const Duration(milliseconds: 300),
          placeholder: (context, url) => placeholder ?? const SizedBox.shrink(),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.coffee_outlined, color: _kDarkCoffeeColor),
                const Gap(8),
                Text(
                  context.l10n.photoLoadError,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _kDarkCoffeeColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
          top: top,
          right: 0,
          child: IconButton(
            icon: Icon(
              photo.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: photo.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => onToggleFavorite(photo.id),
          ),
        ),
        if (automaticallyImplyLeading)
          Positioned(
            top: top,
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
      ],
    );

    if (automaticallyImplyLeading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: child,
      );
    } else {
      return child;
    }
  }
}
