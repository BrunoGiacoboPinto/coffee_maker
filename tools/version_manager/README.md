## Version Manager Tool

A Dart command-line tool to manage versions across all `pubspec.yaml` files in the Coffee Maker project.

### Features

- Updates versions in the main app and all packages synchronously
- Handles Flutter's version+build format (e.g., `1.2.3+4`)
- Automatically increments build numbers
- Validates semantic version format
- Shows current versions of all packages for CI workflows
- Provides raw version output for specific packages (perfect for CI/CD scripts)

### Usage

```bash
# Update versions to a new version
dart run version_manager --version 1.2.3

# Or with short flag
dart run version_manager -v 1.2.3

# Show all package versions with formatting
dart run version_manager --show-all

# Show specific package version (raw output for CI)
dart run version_manager --show app
dart run version_manager --show environment
dart run version_manager --show coffee_photos_repository
dart run version_manager --show network

# Or with short flag
dart run version_manager -s app

# Show help
dart run version_manager --help
```

### Files Updated

- Main app `pubspec.yaml`
- `packages/coffee_photos_repository/pubspec.yaml`
- `packages/environment/pubspec.yaml`
- `packages/network/pubspec.yaml`
