import 'package:coffee_maker/app/view/shell_navigation.dart';
import 'package:coffee_maker/favorites/favorites.dart';
import 'package:coffee_maker/home/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ShellNavigationScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesPage(),
        ),
      ],
    ),
  ],
);
