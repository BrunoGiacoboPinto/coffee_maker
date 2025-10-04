enum AppRoutes {
  home('/home'),
  favorites('/favorites');

  const AppRoutes(this.path);

  final String path;

  static AppRoutes fromPath(String path) {
    return values.firstWhere((route) => route.path == path, orElse: () => home);
  }
}
