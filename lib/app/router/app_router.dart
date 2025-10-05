import 'package:coffee_maker/app/router/app_routes.dart';
import 'package:coffee_maker/app/view/shell_navigation.dart';
import 'package:coffee_maker/coffee_photo_details/coffee_photo_details.dart';
import 'package:coffee_maker/di/injection.dart';
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
          builder: (context, state) => HomePage(homeBloc: getIt<HomeBloc>()),
        ),
        GoRoute(
          name: AppRoutes.favorites.name,
          path: AppRoutes.favorites.path,
          builder: (context, state) => const FavoritesPage(),
        ),
        GoRoute(
          name: AppRoutes.details.name,
          path: AppRoutes.details.path,
          builder: (context, state) {
            final photoId = state.pathParameters['photoId']!;
            return CoffeePhotoDetailsPage(
              photoId: photoId,
              bloc: getIt<CoffeePhotoDetailsBloc>(),
            );
          },
        ),
      ],
    ),
  ],
);
