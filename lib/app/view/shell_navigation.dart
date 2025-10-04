import 'package:coffee_maker/app/router/app_routes.dart';
import 'package:coffee_maker/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class ShellNavigationScaffold extends StatelessWidget {
  const ShellNavigationScaffold({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onTap(context, index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.l10n.homeLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: context.l10n.favoritesLabel,
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final route = AppRoutes.fromPath(GoRouterState.of(context).uri.path);
    return route.index;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.home.name);
      case 1:
        context.goNamed(AppRoutes.favorites.name);
    }
  }
}
