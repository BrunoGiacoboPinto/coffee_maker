import 'package:coffee_maker/app/router/app_routes.dart';
import 'package:coffee_maker/app/view/shell_navigation.dart';
import 'package:coffee_maker/favorites/favorites.dart';
import 'package:coffee_maker/home/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ShellNavigationScaffold(child: child);
      },
      routes: [
        GoRoute(
          name: AppRoutes.home.name,
          path: AppRoutes.home.path,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: AppRoutes.favorites.name,
          path: AppRoutes.favorites.path,
          builder: (context, state) => const FavoritesPage(),
        ),
      ],
    ),
  ],
);
