# Environment Configuration

Type-safe environment configuration using envied.

## Available Configuration Variables

### Public (non-obfuscated):
- `API_BASE_URL`: Base URL for API endpoints
- `CONNECT_TIMEOUT`: Connection timeout in seconds
- `RECEIVE_TIMEOUT`: Receive timeout in seconds
- `PROBE_TIMEOUT`: Internet connectivity probe timeout in seconds
- `PROBE_ENDPOINT`: URL for connectivity checks

### Sensitive (obfuscated):
- `API_KEY`: API authentication key

## Usage

```dart
import 'package:environment/environment.dart';

final baseUrl = Env.apiBaseUrl;
final timeout = Duration(seconds: Env.connectTimeout);
```

## Code Generation

After modifying environment.dart, run:

```bash
cd packages/environment
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```
